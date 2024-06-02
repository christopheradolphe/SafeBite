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
    let cuisine: String //Make this an enum eventually
    let address: [String]
    let phoneNumber: String
    let website: String
}
