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
    var invalidUserInformation: Bool {
        if (firstName.isEmpty || lastName.isEmpty || email.isEmpty || phoneNumber.isEmpty) {
            return true
        }
        return false
    }
}

struct UserProfile: Codable {
    var userInformation = UserInformation()
    var allergens = Allergens()
    var dietaryRestrictions = DietaryRestrictions()
    var favouriteRestaurants: [String : Bool]
    
    init() {
        let restaurants: [Restaurant] = Bundle.main.decode("restaurants.json")
        var favourites = [String: Bool]()
        for restaurant in restaurants {
            favourites[restaurant.name] = false
        }
        self.favouriteRestaurants = favourites
    }
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
    
    private init () {
        if let savedUserProfile = UserDefaults.standard.data(forKey: "User Profile") {
            if let decodedUserProfile = try? JSONDecoder().decode(UserProfile.self, from: savedUserProfile) {
                userProfile = decodedUserProfile
                return
            }
        }
    }
    
    static let shared = User()
}
