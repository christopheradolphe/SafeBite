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

struct IndividualRestaurantView: View {
    @State private var restaurtant: Restaurant
    let menu: Menu
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ZStack {
//                        Image(restaurtant.restaurantThumbnail)
//                            .resizable()
//                            .scaledToFill()
//                            .containerRelativeFrame(.horizontal) { width, axis in
//                                width * 0.9
//                            }
                        Image(restaurtant.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width * 0.4)
                            .clipShape(.circle)
                            .shadow(radius:5)
                    }
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
                        .font(.title2)
                        .padding(.vertical, 10)
                    
                    VStack(alignment: .leading) {
                        Text("Allergy Safe")
                            .font(.title3)
                            .padding(.horizontal)
                        
                        ForEach(restaurtant.menuTypes, id: \.self) { type in
                            MenuTypeView(menu: menu, menuType: type, safetyRating: 0)
                        }
                    }
                    .background(.green)
                    
                    VStack(alignment: .leading) {
                        Text("Item Removal Possible")
                            .font(.title3)
                            .padding(.horizontal)
                        
                        ForEach(restaurtant.menuTypes, id: \.self) { type in
                            MenuTypeView(menu: menu, menuType: type, safetyRating: 1)
                        }
                    }
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .background(.orange)
                    
                    VStack(alignment: .leading) {
                        Text("Allergen in Meal")
                            .font(.title3)
                            .padding(.horizontal)
                        
                        ForEach(restaurtant.menuTypes, id: \.self) { type in
                            MenuTypeView(menu: menu, menuType: type, safetyRating: 2)
                        }
                    }
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .padding(.vertical)
                    .background(.red)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                .navigationTitle(restaurtant.name)
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(.gray)
                .toolbar {
                    Button {
                        restaurtant.favourite.toggle()
                    } label: {
                        Image(systemName: restaurtant.favourite ? "star.fill" : "star")
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
    return IndividualRestaurantView(restaurant: restaurants[7])
}
