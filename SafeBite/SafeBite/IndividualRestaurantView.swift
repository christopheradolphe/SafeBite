//
//  IndividualRestaurantView.swift
//  SafeBite
//
//  Created by Christopher Adolphe on 2024-06-02.
//

import SwiftUI

struct IndividualRestaurantView: View {
    let restaurtant: Restaurant
    let menu: Menu
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Hi")
            }
            .navigationTitle(restaurtant.name)
        }
    }
    
    init(restaurant: Restaurant) {
        self.restaurtant = restaurant
        self.menu = Menu(menuItems: Bundle.main.decode(restaurant.menuJSONname))
    }
}

#Preview {
    IndividualRestaurantView(restaurant: "Miss Bao")
}
