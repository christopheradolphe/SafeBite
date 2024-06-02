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
    let menuTypes = ["SMALL PLATES", "DESSERT", "BAO", "LARGE PLATES"]
        
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("About \(restaurtant.name)")
                    .font(.headline)
                    .padding(.vertical, 10)
                Text(restaurtant.description) //Work to shorten this or make an info button to view
                    .font(.caption)
                    .foregroundStyle(.gray)
                
                Separator()
            }
            .padding(.horizontal)
            
            List(menu.menuItems) { menuItem in
                NavigationLink(menuItem.name, value: menuItem)
            }
            .navigationDestination(for: MenuItem.self) { selection in
                Text("You just selected \(selection.name)")
            }
        .navigationTitle(restaurtant.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.green)
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
