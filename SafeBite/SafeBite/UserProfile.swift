//
//  UserProfile.swift
//  SafeBite
//
//  Created by Christopher Adolphe on 2024-06-15.
//

import Foundation
import CoreLocation
import Combine

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
    var userLocation: CLLocation?
    
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
        self.userLocation = nil
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
        locationManager.$userLocation
            .receive(on: RunLoop.main)
            .compactMap { $0 }
            .sink { [weak self] location in
                self?.userProfile.userLocation = location
            }
            .store(in: &cancellables)
    }
    
    static let shared = User()
    
    private var cancellables = Set<AnyCancellable>()
}
