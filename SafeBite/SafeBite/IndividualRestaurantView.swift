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
                    
                    Text(">")
                        .padding(.horizontal)
                        .foregroundColor(.black)
                }
                .padding(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.gray)
                )
                .padding(.horizontal)
            }
        }
    }
}

struct MenuTypeView: View {
    let menu: Menu
    let menuType: String
    
    var body: some View {
        VStack {
            Text(menuType)
                .font(.subheadline)
            ForEach(menu.menuItems.filter{$0.itemType==menuType}) { menuItem in
                MenuItemView(menuItem: menuItem)
            }
        }
        .padding(.vertical)
    }
}

struct IndividualRestaurantView: View {
    let restaurtant: Restaurant
    let menu: Menu        
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Image(restaurtant.image)
                        .resizable()
                        .scaledToFit()
                        .containerRelativeFrame(.horizontal) { width, axis in
                            width * 0.4
                        }
                        .clipShape(.circle)
                    if restaurtant.description != "" {
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
                }
                .padding(.horizontal)
                
                VStack {
                    Text("Menu")
                        .font(.headline)
                        .padding(.vertical, 10)
                    ForEach(restaurtant.menuTypes, id: \.self) { type in
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
    return IndividualRestaurantView(restaurant: restaurants[7])
}
