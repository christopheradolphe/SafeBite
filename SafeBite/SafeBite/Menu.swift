//
//  Menu.swift
//  SafeBite
//
//  Created by Christopher Adolphe on 2024-06-02.
//

import Foundation

struct MenuItem: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let itemType: String
    let description: String
    
    //Need to find better solution for allergens
    let gluten: Int?
    let sesame: Int?
    let soy: Int?
    let fish: Int?
    let shellfish: Int?
    let dairy: Int?
    let egg: Int?
    let treeNuts: Int?
    let peanuts: Int?
    let wheat: Int?
    let almonds: Int?
    let legumes: Int?
    let mustard: Int?
    let vegetarian: Int?
    let vegan: Int?
    
    var image: String {
        name.lowercased().filter{!$0.isWhitespace}
    }
}

struct Menu: Codable {
    let menuItems: [MenuItem]
}
