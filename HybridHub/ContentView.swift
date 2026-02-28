//
//  ContentView.swift
//  HybridHub
//
//  Created by Paul Festeu on 28.02.2026.
//

import SwiftUI

// --- 1. ECRANUL PRINCIPAL (LISTA DE BIROURI) ---
struct ContentView: View {
    @StateObject private var networkManager = NetworkManager()
    
    @State private var showInactiveAlert = false
    @State private var inactiveDeskName = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor.systemGroupedBackground).ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Alege un birou pentru detalii")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                            .padding(.top, 10)
                        
                        ForEach(networkManager.desks) { desk in
                            
                            if desk.is_active {
                                NavigationLink(destination: DeskDetailView(desk: desk, networkManager: networkManager)) {
                                    DeskCardView(desk: desk)
                                }
                                .buttonStyle(PlainButtonStyle())
                                
                            } else {

                                Button(action: {
                                    inactiveDeskName = desk.label
                                    showInactiveAlert = true
                                }) {
                                    DeskCardView(desk: desk)
                                        .opacity(0.8)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationTitle("HybridHub Cluj")
            .onAppear {
                networkManager.fetchDesks()
            }
            .alert(isPresented: $showInactiveAlert) {
                Alert(
                    title: Text("Indisponibil"),
                    message: Text("\(inactiveDeskName) nu este disponibil pentru rezervări în acest moment. Ne cerem scuze pentru neplăcere!"),
                    dismissButton: .default(Text("Am înțeles"))
                )
            }
        }
    }
}

// --- 2. ECRANUL NOU (DETALII BIROU & REZERVARE) ---
struct DeskDetailView: View {
    let desk: Desk
    @ObservedObject var networkManager: NetworkManager
    
    @State private var selectedDate = Date()
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground).ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    
                    AsyncImage(url: URL(string: desk.image_url ?? "")) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(height: 220)
                                .frame(maxWidth: .infinity)
                                .background(Color.gray.opacity(0.1))
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 220)
                                .frame(maxWidth: .infinity)
                                .clipped()
                        case .failure:
                            Image(systemName: "macbook.and.ipad")
                                .font(.system(size: 80))
                                .foregroundColor(.gray)
                                .frame(height: 220)
                                .frame(maxWidth: .infinity)
                                .background(Color.gray.opacity(0.1))
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Facilități incluse")
                            .font(.headline)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(desk.facilities ?? [], id: \.self) { facility in
                                    FacilityTag(
                                        icon: facility.contains("Monitor") ? "display" :
                                            facility.contains("Scaun") ? "chair.lounge.fill" :
                                            facility.contains("Lumină") ? "sun.max.fill" :
                                            facility.contains("Liniște") ? "earbuds" : "star.fill",
                                        text: facility
                                    )
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    
                    
                    VStack(alignment: .leading) {
                        Text("Selectează data")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        DatePicker("", selection: $selectedDate, displayedComponents: .date)
                            .datePickerStyle(.graphical)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(16)
                            .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
                            .padding(.horizontal)
                    }
                    
                    Button(action: {
                        rezervaBirou(deskId: desk.id)
                    }) {
                        Text("Confirmă Rezervarea")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(desk.is_active ? Color.blue : Color.gray)
                            .cornerRadius(16)
                            .shadow(color: desk.is_active ? Color.blue.opacity(0.3) : Color.clear, radius: 10, x: 0, y: 5)
                    }
                    .disabled(!desk.is_active)
                    .padding(.horizontal)
                    .padding(.top, 10)
                }
                .padding(.bottom, 40)
            }
        }
        .navigationTitle(desk.label)
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Status Rezervare"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    func rezervaBirou(deskId: Int) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: selectedDate)
        
        networkManager.bookDesk(deskId: deskId, date: dateString) { success, mesaj in
            self.alertMessage = mesaj
            self.showAlert = true
        }
    }
}

// --- 3. COMPONENTE MICI DE DESIGN ---

struct FacilityTag: View {
    let icon: String
    let text: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.blue)
            Text(text)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(width: 80, height: 80)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

struct DeskCardView: View {
    let desk: Desk
    
    var body: some View {
        HStack(spacing: 16) {
            
            AsyncImage(url: URL(string: desk.image_url ?? "")) { phase in
                switch phase {
                case .empty:
                    ZStack {
                        Circle().fill(Color.gray.opacity(0.1)).frame(width: 60, height: 60)
                        ProgressView()
                    }
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                        .saturation(desk.is_active ? 1.0 : 0.0)
                case .failure:
                    ZStack {
                        Circle().fill(Color.blue.opacity(0.1)).frame(width: 60, height: 60)
                        Image(systemName: "desktopcomputer").foregroundColor(.blue)
                    }
                @unknown default:
                    EmptyView()
                }
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(desk.label)
                    .font(.headline)
                    .foregroundColor(desk.is_active ? .primary : .gray)
                
                // AICI AM REPARAT: Readucem textul verde "Disponibil"
                if desk.is_active {
                    HStack(spacing: 4) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.caption)
                        Text("Disponibil")
                            .font(.subheadline)
                    }
                    .foregroundColor(.green)
                } else {
                    // Și păstrăm textul roșu pentru mentenanță
                    HStack(spacing: 4) {
                        Image(systemName: "wrench.and.screwdriver.fill")
                            .font(.caption)
                        Text("În mentenanță")
                            .font(.subheadline)
                    }
                    .foregroundColor(.red)
                }
            }
            Spacer()
            
            Image(systemName: desk.is_active ? "chevron.right" : "lock.fill")
                .foregroundColor(desk.is_active ? .gray.opacity(0.5) : .red.opacity(0.5))
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
    }
}

#Preview {
    ContentView()
}
