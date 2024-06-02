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
            ScrollView {
                VStack(alignment: .leading) {
                    Text("About \(restaurtant.name)")
                        .font(.headline)
                        .padding(.vertical, 10)
                    Text(restaurtant.description)
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
                .padding(.horizontal)
                .navigationTitle(restaurtant.name)
                .navigationBarTitleDisplayMode(.inline)
                
                VStack {
                    ForEach(menu.menuItems) { menuItem in
                        NavigationLink(menuItem.name)
                    }
                    .navigationDestination(for: MenuItem.self) { selection in
                        Text("You just selected \(selection.name)")
                    }
                }
            }
        }
    }
    
    init(restaurant: Restaurant) {
        self.restaurtant = restaurant
        self.menu = Menu(menuItems: Bundle.main.decode(restaurant.menuJSONname))
    }
}

#Preview {
    let restaurants: [Restaurant] = Bundle.main.decode("restaurants.json")
    return IndividualRestaurantView(restaurant: restaurants[6])
}
