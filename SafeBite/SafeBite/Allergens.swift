//
//  Allergens.swift
//  SafeBite
//
//  Created by Christopher Adolphe on 2024-06-15.
//

import Foundation

struct Allergens: Codable {
    var gluten = false
    var wheat = false
    var soy = false
    var shellfish = false
    var fish = false
    var dairy = false
    var egg = false
    var treeNuts = false
    var peanuts = false
    var sesame = false
    var mustard = false
    var garlic = false
    var sulfites = false
}

struct DietaryRestrictions: Codable {
    var vegan = false
    var vegetarian = false
    var halal = false
    var keto = false
    var lowCarb = false
    var lowFODMAP = false
    var dashDiet = false
}
