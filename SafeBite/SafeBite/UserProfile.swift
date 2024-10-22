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
    var userProfileMade = false
    var userInformation = UserInformation()
    var allergens = Allergens()
    var dietaryRestrictions = DietaryRestrictions()
    var favouriteRestaurants: [String : Bool]
    
    enum CodingKeys: String, CodingKey {
        case userProfileMade, userInformation, allergens, dietaryRestrictions, favouriteRestaurants
    }
    
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
class User: ObservableObject {
    var userProfile = UserProfile() {
        didSet {
            if let encoded = try? JSONEncoder().encode(userProfile) {
                UserDefaults.standard.set(encoded, forKey: "User Profile")
            }
        }
    }
    
    private var locationManager = LocationManager()
    
    private init () {
        if let savedUserProfile = UserDefaults.standard.data(forKey: "User Profile") {
            if let decodedUserProfile = try? JSONDecoder().decode(UserProfile.self, from: savedUserProfile) {
                userProfile = decodedUserProfile
            }
        }
    }
    
    static let shared = User()
}
