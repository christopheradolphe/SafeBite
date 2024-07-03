//
//  Restaurant.swift
//  SafeBite
//
//  Created by Christopher Adolphe on 2024-06-02.
//

import Foundation

struct Restaurant: Codable, Identifiable {
    let id: Int
    let name: String
    let description: String
    let cuisine: String  //change back to cuisine
    let address: String //change to list of strings eventually
    let phoneNumber: String
    let website: String
    let menuTypes: [String]
    var favourite = false
    
    var image: String {
        name.lowercased().filter{!$0.isWhitespace}
    }
    
    var menuJSONname: String {
        name.lowercased().filter{!$0.isWhitespace} + ".json"
    }
    
    var restaurantThumbnail: String {
        name.lowercased().filter{!$0.isWhitespace} + "thumbnail"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case cuisine
        case address
        case phoneNumber
        case website
        case menuTypes
            // Do not include `newField` here
    }
    
    var menu: Menu {
        Menu(menuItems: Bundle.main.decode(menuJSONname))
    }
}

enum Cuisine: Codable {
    case Asian, Italian, Tapas, Steakhouse, BarAndGrill, Mexican
}
