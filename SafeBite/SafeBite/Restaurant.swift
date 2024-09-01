//
//  Restaurant.swift
//  SafeBite
//
//  Created by Christopher Adolphe on 2024-06-02.
//

import Foundation
import CoreLocation

struct Restaurant: Codable, Identifiable {
    let id: Int
    let name: String
    let description: String
    let cuisine: String  //change back to cuisine
    let address: String //change to list of strings eventually
    let phoneNumber: String
    let website: String
    let menuTypes: [String]
    let location: String //Change to list of strings eventually
    
    var image: String {
        name.lowercased().filter{!$0.isWhitespace}
    }
    
    var menuJSONname: String {
        name.lowercased().filter{!$0.isWhitespace} + ".json"
    }
    
    var restaurantThumbnail: String {
        name.lowercased().filter{!$0.isWhitespace} + "thumbnail"
    }
    
    var coordinate: CLLocationCoordinate2D? {
        get {
            // Attempt to get the coordinates synchronously
            if let location = getCoordinate(from: address) {
                return location
            }
            return nil
        }
    }
    
    private func getCoordinate(from address: String) -> CLLocationCoordinate2D? {
        var coordinate: CLLocationCoordinate2D?
        let geocoder = CLGeocoder()
        let semaphore = DispatchSemaphore(value: 0) // For synchronous call
        
        geocoder.geocodeAddressString(address) { placemarks, error in
            if let placemark = placemarks?.first, let location = placemark.location {
                coordinate = location.coordinate
            }
            semaphore.signal() // Signal to continue after geocoding
        }
        
        // Wait until geocoding is complete
        semaphore.wait()
        return coordinate
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
        case location
            // Do not include `newField` here
    }
    
    var menu: Menu {
        Menu(menuItems: Bundle.main.decode(menuJSONname))
    }
}

enum Cuisine: Codable {
    case Asian, Italian, Tapas, Steakhouse, BarAndGrill, Mexican
}
