//
//  Menu.swift
//  SafeBite
//
//  Created by Christopher Adolphe on 2024-06-02.
//

import Foundation

struct MenuItem: Codable, Identifiable {
    let id: Int
    let name: String
    let itemType: String
    let allergens: [String]
    let image: String //maybe make this computed
    let description: String
}

struct Menu: Codable {
    let MenuItems: [MenuItem]
}
