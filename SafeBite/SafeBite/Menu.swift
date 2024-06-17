//
//  Menu.swift
//  SafeBite
//
//  Created by Christopher Adolphe on 2024-06-02.
//

import Foundation

struct AllergenInfo: Codable, Hashable {
    let gluten: Int?
    let wheat: Int?
    let soy: Int?
    let shellfish: Int?
    let fish: Int?
    let dairy: Int?
    let egg: Int?
    let treeNuts: Int?
    let almonds: Int?
    let peanuts: Int?
    let sesame: Int?
    let mustard: Int?
    let garlic: Int?
    let sulfites: Int?
    let legumes: Int?
}

struct DietaryRestrictionInfo: Codable, Hashable {
    let vegan: Int?
    let vegetarian: Int?
    let halal: Int?
    let keto: Int?
    let lowCarb: Int?
    let lowFODMAP: Int?
    let dashDiet: Int?
}

struct MenuItem: Codable, Identifiable, Hashable {
    let id = UUID()
    let name: String
    let itemType: String
    let description: String?
    
    let allergenInfo: [String: Int]
    let dietaryRestrictionInfo: [String: Int]
    
    var image: String {
        name.lowercased().filter{!$0.isWhitespace}
    }
}

struct Menu: Codable {
    let menuItems: [MenuItem]
}
