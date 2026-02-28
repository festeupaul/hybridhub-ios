//
//  Desk.swift
//  HybridHub
//
//  Created by Paul Festeu on 28.02.2026.
//


import Foundation

struct Desk: Identifiable, Codable {
    let id: Int
    let label: String
    let is_active: Bool
    let image_url: String?
    let facilities: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case label
        case is_active = "is_active"
        case image_url = "image_url"
        case facilities = "facilities"
    }
}
