import SwiftUI

struct ContentView: View {
    @StateObject private var networkManager = NetworkManager()
    
    // Variabile de "State" - când acestea se modifică, ecranul se redesenează automat
    @State private var selectedDate = Date() // Data aleasă de utilizator (azi by default)
    @State private var showAlert = false     // Controlează dacă afișăm pop-up-ul
    @State private var alertMessage = ""     // Mesajul din pop-up
    
    var body: some View {
        NavigationView {
            VStack {
                // 1. Selectorul de dată (Calendarul superb nativ din iOS)
                DatePicker("Alege data", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .padding(.horizontal)
                
                // 2. Lista de birouri
                List(networkManager.desks) { desk in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(desk.label)
                                .font(.headline)
                            Text(desk.is_active ? "Disponibil" : "Indisponibil")
                                .font(.subheadline)
                                .foregroundColor(desk.is_active ? .green : .red)
                        }
                        
                        Spacer()
                        
                        // 3. Butonul real de rezervare
                        Button(action: {
                            rezervaBirou(deskId: desk.id)
                        }) {
                            Text("Rezervă")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(desk.is_active ? Color.blue : Color.gray)
                                .cornerRadius(8)
                        }
                        .disabled(!desk.is_active) // Nu lăsăm utilizatorul să rezerve birouri inactive
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("HybridHub Cluj")
            .onAppear {
                networkManager.fetchDesks() // Aducem birourile la pornirea aplicației
            }
            // 4. Aici "prindem" răspunsul de la server și îl arătăm ca un pop-up
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Status Rezervare"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
    
    // --- Funcție ajutătoare pentru a formata data și a cere rezervarea ---
    func rezervaBirou(deskId: Int) {
        // Backend-ul nostru așteaptă data în format "YYYY-MM-DD", dar iOS folosește un format complex (Date).
        // Așa că folosim DateFormatter pentru a o traduce.
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: selectedDate)
        
        // Apelăm motorul de rețea pe care l-ai creat mai devreme
        networkManager.bookDesk(deskId: deskId, date: dateString) { success, mesaj in
            // Când primim răspunsul din cloud, setăm mesajul și declanșăm pop-up-ul
            self.alertMessage = mesaj
            self.showAlert = true
        }
    }
}

#Preview {
    ContentView()
}
