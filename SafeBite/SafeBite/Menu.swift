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
    let description: String
    
    let allergenInfo: [String: Int]
    let dietaryRestrictionInfo: [String: Int]
    
    var image: String {
        name.lowercased().filter{!$0.isWhitespace}
    }
    
    var safeBiteValue: Int {
        let user = User()
        var safe = true
        for allergy in user.userProfile.allergens.allergenList {
            if allergenInfo[allergy] == 2 {
                return 2
            } else if allergenInfo[allergy] == 1 {
                safe = false
            }
        }
        
        for diet in user.userProfile.dietaryRestrictions.dietaryRestrictionList {
            if dietaryRestrictionInfo[diet] == 2 {
                return 2
            } else if dietaryRestrictionInfo[diet] == 1 {
                safe = false
            }
        }
        
        return safe ? 0 : 1
    }
}

struct Menu: Codable {
    let menuItems: [MenuItem]
    
    var totalItems: Int {
        menuItems.count
    }
    
    var safeItems: Int {
        menuItems.filter{$0.safeBiteValue==0}.count
    }
    
    var modifiableItems: Int {
        menuItems.filter{$0.safeBiteValue==1}.count
    }
    
    var unsafeItems: Int {
        menuItems.filter{$0.safeBiteValue==2}.count
    }
}
