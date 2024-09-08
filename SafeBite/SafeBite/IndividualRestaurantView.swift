//
//  IndividualRestaurantView.swift
//  SafeBite
//
//  Created by Christopher Adolphe on 2024-06-02.
//

import SwiftUI
import MapKit


func imageExists(named name: String) -> Bool {
    return UIImage(named: name) != nil
}

struct MenuItemView: View {
    var menuItem: MenuItem
    let restaurantName: String
    let safeBiteValue: Int
    @State private var showItemDetail = false
    
    var iconName: String {
        switch safeBiteValue {
        case 0:
            return "checkmark.circle.fill" // Green checkmark
        case 1:
            return "exclamationmark.circle.fill" // Yellow dot
        case 2:
            return "xmark.circle.fill" // Red X
        default:
            return ""
        }
    }
    
    var body: some View {
        let primaryImageName = restaurantName.lowercased().filter{!$0.isWhitespace} + "_" + menuItem.image
        let fallbackImageName = restaurantName.lowercased().filter{!$0.isWhitespace}
        let imageName = imageExists(named: primaryImageName) ? primaryImageName : fallbackImageName

        VStack {
            HStack {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width:80, height: 80)
                VStack (alignment: .leading) {
                    Text(menuItem.name)
                        .padding(.horizontal)
                        .foregroundColor(.black)
                    Text(menuItem.description)
                        .padding(.horizontal)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                        .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                }
                
                Spacer()
                VStack {
                    Image(systemName: iconName) // Use the determined icon here
                        .foregroundColor(safeBiteValue == 0 ? .green : safeBiteValue == 1 ? .yellow : .red)
                        .padding(5)
                }
            }
            .padding(5)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white).shadow(radius: 10))
            .padding(.horizontal)
            .onTapGesture {
                showItemDetail.toggle()
            }
        }
        .sheet(isPresented: $showItemDetail) {
            ItemView(menuItem: menuItem, isPresented: $showItemDetail)
                .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all))
                .presentationDetents([.medium])
        }
    }
}

struct MenuTypeView: View {
    let menu: Menu
    let menuType: String
    let safetyRating: Int
    let restaurantName: String
    var menuTypeItems: [MenuItem] {
        if safetyRating == -1 {
            return menu.menuItems.filter { $0.itemType == menuType }
        } else {
            return menu.menuItems.filter { $0.itemType == menuType && $0.safeBiteValue == safetyRating }
        }
    }
    
    var body: some View {
        
        if (!menuTypeItems.isEmpty) {
            VStack {
                Text(menuType)
                    .font(.subheadline)
                    .padding(.bottom, 5)
                    .frame(maxWidth:.infinity)

                ForEach(menuTypeItems) { menuItem in
                    MenuItemView(menuItem: menuItem, restaurantName: restaurantName, safeBiteValue: menuItem.safeBiteValue)
                }
            }
            .padding(.vertical)
        }
    }
}

struct ItemCatergoryView: View {
    let restaurant: Restaurant
    let menu: Menu
    let safeBiteCatergory: Int
    var menuType: String
    
    var body: some View {
        VStack(alignment: .leading) {
            if menuType == "All" {
                ForEach(restaurant.menuTypes, id: \.self) { type in
                    MenuTypeView(menu: menu, menuType: type, safetyRating: safeBiteCatergory, restaurantName: restaurant.name)
                }
            } else {
                MenuTypeView(menu: menu, menuType: menuType, safetyRating: safeBiteCatergory, restaurantName: restaurant.name)
            }
        }
        .background {
            switch safeBiteCatergory {
            case 0:
                Color.green.opacity(0.6)
            case 1:
                Color.orange.opacity(0.6)
            case 2:
                Color.red.opacity(0.6)
            default:
                Color.white
            }
        }
        .cornerRadius(10)
        .padding(.bottom, 10)
        .padding(.horizontal, 10)
    }
}

struct IndividualRestaurantView: View {
    @State var restaurant: Restaurant
    @State private var showDescription = false
    @State private var selection = 3
    @State private var selectedSafety: Int = -1
    @State private var selectedMenuType: String = "All"
    private var categoryName: String {
        switch selectedSafety {
        case 0:
            return "Allergy Safe"
        case 1:
            return "Modifiable"
        case 2:
            return "Unsafe"
        default:
            return "All"
        }
    }
    
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
                
                Divider()
                
                VStack (alignment: .leading){
                    HStack {
                        Text("About \(restaurant.name)")
                            .font(.title3)
                            .padding(.leading, 20)
                        
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
                .padding(.bottom)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .padding(20)
                        .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 5)
                    
                    VStack {
                        Picker(selection: $selection, label: Text("")) {
                            Image(systemName: "globe")
                                .tag(0)
                            Image(systemName: "phone")
                                .tag(1)
                            Image(systemName: "map")
                                .tag(2)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .accentColor(.green)
                        .padding()
                        
                        if selection == 0 {
                            VStack(alignment: .center) {
                                Text("Website")
                                Link(restaurant.website, destination: URL(string: restaurant.website)!)
                                    .font(.headline.bold())
                                    .foregroundColor(.blue)
                                    .padding(5)
                            }
                            .transition(.opacity)
                        } else if selection == 1 {
                            VStack(alignment: .center) {
                                Text("Phone Number")
                                Link(restaurant.phoneNumber, destination: URL(string: "tel:+\(restaurant.phoneNumber)")!)
                                    .font(.headline.bold())
                                    .foregroundColor(.blue)
                            }
                            .transition(.opacity)
                        } else if selection == 2 {
                            VStack {
                                Text("Map")
                                MapView(address: restaurant.address)
                                    .frame(height: 200)
                                    .padding(.bottom, 10)
                                
                                Text(restaurant.address)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 20)
                            }
                            .transition(.opacity)
                        }
                        
                        Spacer()
                    }
                    .padding(30)
                }
                
                Divider()
                
                VStack {
                    HStack {
                        Picker("Select Category", selection: $selectedSafety) {
                            Text("All (Safety)")
                                .tag(-1)
                            Text("Allergy Safe")
                                .tag(0)
                            Text("Modifiable")
                                .tag(1)
                            Text("Unsafe")
                                .tag(2)
                        }
                        .pickerStyle(MenuPickerStyle()) // Use MenuPickerStyle for a dropdown menu appearance
                        .frame(width: 160, height: 30) // Slightly wider to accommodate text
                        .padding(5) // Reduced padding for compactness
                        .background(Color.white)
                        .clipShape(Capsule())
                        .shadow(radius: 3) // Adjust shadow for a subtle effect
                        .foregroundColor(.black) // Text color
                        .font(.system(size: 10, weight: .medium))
                        .padding(.horizontal)
                        
                        Picker("Select Menu Type", selection: $selectedMenuType) {
                                    Text("All (Menu Types)").tag("All")
                                    ForEach(restaurant.menuTypes, id: \.self) { type in
                                        Text(type).tag(type)
                                    }
                        }
                        .pickerStyle(MenuPickerStyle()) // Use MenuPickerStyle for a dropdown menu appearance
                        .frame(width: 180, height: 30) // Adjust width and height for a smaller appearance
                        .padding(5)
                        .background(Color.white)
                        .clipShape(Capsule())
                        .shadow(radius: 3) // Adjust shadow for a less prominent effect
                        .foregroundColor(.black)
                        .font(.system(size: 10, weight: .regular))
                        .fixedSize(horizontal: true, vertical: false) // Ensure the text fits within the frame
                        .layoutPriority(1)
                        
                        Spacer()
                    }
                    
                    switch selectedSafety {
                    case 0:
                        ItemCatergoryView(restaurant: restaurant, menu: restaurant.menu, safeBiteCatergory: 0, menuType: selectedMenuType)
                    case 1:
                        ItemCatergoryView(restaurant: restaurant, menu: restaurant.menu, safeBiteCatergory: 1, menuType: selectedMenuType)
                    case 2:
                        ItemCatergoryView(restaurant: restaurant, menu: restaurant.menu, safeBiteCatergory: 2, menuType: selectedMenuType)
                    case -1:
                        ItemCatergoryView(restaurant: restaurant, menu: restaurant.menu, safeBiteCatergory: -1, menuType: selectedMenuType)
                    default:
                        EmptyView()
                    }
                    
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
                            .foregroundStyle(.yellow)
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
            .background(Color(red: 245/255, green: 244/255, blue: 240/255))
            .toolbarBackground(Color(red: 60 / 255, green: 180 / 255, blue: 75 / 255), for: .navigationBar)
        }
    }
}

#Preview {
    let restaurants: [Restaurant] = Bundle.main.decode("restaurants.json")
    return IndividualRestaurantView(restaurant: restaurants[8])
}
