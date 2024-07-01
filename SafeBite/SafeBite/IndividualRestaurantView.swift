//
//  IndividualRestaurantView.swift
//  SafeBite
//
//  Created by Christopher Adolphe on 2024-06-02.
//

import SwiftUI

struct MenuItemView: View {
    var menuItem: MenuItem
    
    var body: some View {
        NavigationLink {
            ItemView(menuItem: menuItem)
        } label: {
            VStack {
                HStack {
                    Text(menuItem.name)
                        .padding(.horizontal)
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .padding(.horizontal)
                        .foregroundColor(.gray)
                }
                .padding(5)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white).shadow(radius: 10))
                .padding(.horizontal)
            }
        }
    }
}

struct MenuTypeView: View {
    let menu: Menu
    let menuType: String
    let safetyRating: Int
    
    var body: some View {
        VStack {
            let menuTypeItems = menu.menuItems.filter{$0.itemType==menuType}.filter{$0.safeBiteValue==safetyRating}
            Text(menuType)
                .font(.subheadline)
                .padding(.bottom, 5)
                .frame(maxWidth:.infinity)
            if menuTypeItems.isEmpty {
                Text("No items fit this catergory")
            }
            ForEach(menu.menuItems.filter{$0.itemType==menuType}.filter{$0.safeBiteValue==safetyRating}) { menuItem in
                MenuItemView(menuItem: menuItem)
            }
        }
        .padding(.vertical)
    }
}

struct ItemCatergoryView: View {
    let restaurant: Restaurant
    let menu: Menu
    let safeBiteCatergory: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(safeBiteCatergory == 0 ? "Allergy Safe" : safeBiteCatergory == 1 ? "Item Removal Possible" : "Contains Allergen")
                .font(.title3)
                .padding(.horizontal)
            
            ForEach(restaurant.menuTypes, id: \.self) { type in
                MenuTypeView(menu: menu, menuType: type, safetyRating: safeBiteCatergory)
            }
        }
        .background(safeBiteCatergory == 0 ? Color.green.opacity(0.6) : safeBiteCatergory == 1 ? Color.orange.opacity(0.6) : Color.red.opacity(0.6))
        .cornerRadius(10)
        .padding(.bottom, 10)
    }
}

struct IndividualRestaurantView: View {
    @State private var restaurant: Restaurant
    let menu: Menu
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ZStack {
                        Image(restaurant.restaurantThumbnail)
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width)
                        VStack {
                            Spacer()
                            
                            Image(restaurant.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.main.bounds.width * 0.3)
                                .clipShape(.circle)
                                .shadow(radius:5)
                        }
                    }
                    .padding(.bottom, 20)
                    
                    if restaurant.description != "" {
                        VStack(alignment: .leading) {
                            Text("About \(restaurant.name)")
                                .font(.headline)
                                .padding(.vertical, 10)
                            Text(restaurant.description) //Work to shorten this or make an info button to view
                                .font(.caption)
                                .foregroundStyle(.gray)
                            
                            Divider()
                        }
                    }
                }
                .padding(.horizontal)
                
                VStack {
                    Text("Menu")
                        .font(.title2)
                        .padding(.vertical, 10)
                    
                    ItemCatergoryView(restaurant: restaurant, menu: menu, safeBiteCatergory: 0)
                    
                    ItemCatergoryView(restaurant: restaurant, menu: menu, safeBiteCatergory: 1)
                    
                    ItemCatergoryView(restaurant: restaurant, menu: menu, safeBiteCatergory: 2)
                }
                .padding(.horizontal)
                
                .navigationTitle(restaurant.name)
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(.gray)
                .toolbar {
                    Button {
                        restaurant.favourite.toggle()
                    } label: {
                        Image(systemName: restaurant.favourite ? "star.fill" : "star")
                    }
                }
            }
        }
    }
    
    init(restaurant: Restaurant) {
        self.restaurant = restaurant
        self.menu = Menu(menuItems: Bundle.main.decode(restaurant.menuJSONname))
    }
}

#Preview {
    let restaurants: [Restaurant] = Bundle.main.decode("restaurants.json")
    return IndividualRestaurantView(restaurant: restaurants[7])
}
