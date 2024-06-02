//
//  Restaurant.swift
//  SafeBite
//
//  Created by Christopher Adolphe on 2024-06-02.
//

import Foundation

struct Restaurant: Codable, Identifiable {
    let id: String
    let name: String
    let description: String
    let cuisine: String  //change back to cuisine
    let address: [String]
    let phoneNumber: String
    let website: String
    //let menu: Menu
    
    var image: String {
        name.lowercased().filter{!$0.isWhitespace}
    }
}

enum Cuisine: Codable {
    case Asian, Italian, Tapas, Steakhouse, BarAndGrill, Mexican
}
