//
//  IndividualRestaurantView.swift
//  SafeBite
//
//  Created by Christopher Adolphe on 2024-06-02.
//

import SwiftUI

struct MenuTypeView: View {
    let menu: Menu
    let menuType: String
    let allergens = ["gluten", "eggs", "vegetarian", "peanuts"]
    
    var body: some View {
        Text(menuType)
            .font(.subheadline)
        ForEach(menu.menuItems.filter{$0.itemType==menuType}) { menuItem in
            NavigationLink(menuItem.name, value: menuItem)
        }
        .navigationDestination(for: MenuItem.self) { selection in
            Text(selection.name)
                .font(.title)
                .padding()
            Text("Allergens included")
                .font(.headline)
                .padding()
            ForEach(allergens, id: \.self) { allergen in
                Text(allergen)
            }
        }
    }
}

struct IndividualRestaurantView: View {
    let restaurtant: Restaurant
    let menu: Menu
    let menuTypes = ["SMALL PLATES", "DESSERT", "BAO", "LARGE PLATES"]
        
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Image("missbao")
                        .resizable()
                        .scaledToFit()
                        .containerRelativeFrame(.horizontal) { width, axis in
                            width * 0.4
                        }
                    VStack(alignment: .leading) {
                        Text("About \(restaurtant.name)")
                            .font(.headline)
                            .padding(.vertical, 10)
                        Text(restaurtant.description) //Work to shorten this or make an info button to view
                            .font(.caption)
                            .foregroundStyle(.gray)
                        
                        Separator()
                    }
                }
                .padding(.horizontal)
                
                VStack() {
                    Text("Menu")
                        .font(.headline)
                        .padding(.vertical, 10)
                    ForEach(menuTypes, id: \.self) { type in
                        MenuTypeView(menu: menu, menuType: type)
                    }
                }
                .frame(maxWidth: .infinity)
                
                .navigationTitle(restaurtant.name)
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(.green)
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
