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
    
    @State var isExpanded: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            DisclosureGroup(isExpanded: $isExpanded) {
                ForEach(restaurant.menuTypes, id: \.self) { type in
                    MenuTypeView(menu: menu, menuType: type, safetyRating: safeBiteCatergory)
                }
            } label: {
                HStack {
                    Text(safeBiteCatergory == 0 ? "Allergy Safe" : safeBiteCatergory == 1 ? "Item Removal Possible" : "Contains Allergen")
                        .font(.title3)
                        .foregroundStyle(.black)
                        .padding()
                    
                    Spacer()
                    
                    Text("\(Int( safeBiteCatergory == 0 ? restaurant.menu.safeItems : safeBiteCatergory == 1 ? restaurant.menu.modifiableItems : restaurant.menu.unsafeItems))")
                        .font(.title3)
                        .foregroundStyle(.gray)
                        .padding()
                }
            }
        }
        .background(safeBiteCatergory == 0 ? Color.green.opacity(0.6) : safeBiteCatergory == 1 ? Color.orange.opacity(0.6) : Color.red.opacity(0.6))
        .cornerRadius(10)
        .padding(.bottom, 10)
        .padding(.horizontal, 5)
    }
}

struct IndividualRestaurantView: View {
    @State var restaurant: Restaurant
    @State private var showDescription = false
    
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
                    
                }
                .padding(.horizontal)
                
                VStack (alignment: .leading){
                    HStack {
                        Text("About \(restaurant.name)")
                            .font(.title3)
                            .padding(.leading)
                        
                        if !restaurant.description.isEmpty{
                            Button(action: {
                                withAnimation {
                                    showDescription.toggle()
                                }
                            }) {
                                Image(systemName: "info.circle")
                            }
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                }
                
                VStack {
                    Text("Menu")
                        .font(.title2)
                        .padding(.vertical, 10)
                    
                    ItemCatergoryView(restaurant: restaurant, menu: restaurant.menu, safeBiteCatergory: 0, isExpanded: true)
                    
                    ItemCatergoryView(restaurant: restaurant, menu: restaurant.menu, safeBiteCatergory: 1, isExpanded: false)
                    
                    ItemCatergoryView(restaurant: restaurant, menu: restaurant.menu, safeBiteCatergory: 2, isExpanded: false)
                }
                .padding(.horizontal)
                
                .navigationTitle(restaurant.name)
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(.gray)
                .toolbar {
                    
                    Button {
                        User.shared.userProfile.favouriteRestaurants[restaurant.name]?.toggle()
                    } label: {
                        Image(systemName: User.shared.userProfile.favouriteRestaurants[restaurant.name] ?? false ? "star.fill" : "star")
                    }
                }
                .sheet(isPresented: $showDescription) {
                    // Sheet content
                    VStack {
                        ScrollView {
                            VStack(alignment: .leading, spacing: 10) {
                                HStack {
                                    Text("About \(restaurant.name)")
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                        .padding(.vertical, 10)
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        withAnimation {
                                            showDescription.toggle()
                                        }
                                    }) {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundColor(.gray)
                                            .imageScale(.large)
                                    }
                                    .padding()
                                }
                                
                                Text(restaurant.description)
                                    .font(.body)
                                    .foregroundColor(.secondary)
                                    .padding(.horizontal)
                                
                                Spacer()
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 20).fill(Color.white).shadow(radius: 10))
                            .padding()
                        }
                    }
                    .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all))
                    .navigationTitle("Restaurant Info")
                    .presentationDetents([.medium])
                }
            }
        }
    }
}

#Preview {
    let restaurants: [Restaurant] = Bundle.main.decode("restaurants.json")
    return IndividualRestaurantView(restaurant: restaurants[1])
}
