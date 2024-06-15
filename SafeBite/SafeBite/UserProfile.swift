//
//  UserProfile.swift
//  SafeBite
//
//  Created by Christopher Adolphe on 2024-06-15.
//

import Foundation

struct UserInformation: Codable {
    var firstName = ""
    var lastName = ""
    var email = ""
    var phoneNumber = ""
}

struct UserProfile: Codable {
    var userInformation = UserInformation()
    var allergens = Allergens()
    var dietaryRestrictions = DietaryRestrictions()
}

@Observable
class User {
    var userProfile = UserProfile() {
        didSet {
            if let encoded = try? JSONEncoder().encode(userProfile) {
                UserDefaults.standard.set(encoded, forKey: "User Profile")
            }
        }
    }
    
    init () {
        if let savedUserProfile = UserDefaults.standard.data(forKey: "User Profile") {
            if let decodedUserProfile = try? JSONDecoder().decode(UserProfile.self, from: savedUserProfile) {
                userProfile = decodedUserProfile
                return
            }
        }
    }
}
