//
//  NetworkManager.swift
//  HybridHub
//
//  Created by Paul Festeu on 28.02.2026.
//

import Foundation
import Combine

class NetworkManager: ObservableObject {
    
    @Published var desks: [Desk] = []
    
    func fetchDesks() {
        guard let url = URL(string: "https://hybridhub-backend.onrender.com/api/desks") else {
            print("URL invalid")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Eroare de rețea: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else { return }
            
            do {
                let decodedDesks = try JSONDecoder().decode([Desk].self, from: data)
                
                DispatchQueue.main.async {
                    self.desks = decodedDesks
                }
            } catch {
                print("Eroare la decodarea JSON-ului: \(error)")
            }
        }.resume()
    }
    func bookDesk(deskId: Int, date: String, completion: @escaping (Bool, String) -> Void) {
        
        guard let url = URL(string: "https://hybridhub-backend.onrender.com/api/reservations") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "user_id": 1,
            "desk_id": deskId,
            "reservation_date": date
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async { completion(false, "Eroare de rețea") }
                return
            }
            
            DispatchQueue.main.async {
                if httpResponse.statusCode == 201 {
                    completion(true, "Rezervare confirmată cu succes!")
                } else if httpResponse.statusCode == 409 {
                    completion(false, "Biroul este deja rezervat pentru această dată.")
                } else {
                    completion(false, "A apărut o eroare neașteptată.")
                }
            }
        }.resume()
    }
}

