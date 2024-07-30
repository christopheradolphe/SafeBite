//
//  ContentView.swift
//  SafeBite
//
//  Created by Christopher Adolphe on 2024-06-02.
//

import SwiftUI

struct Separator: View {
    var body: some View {
         Rectangle()
            .frame(height: 2)
            .foregroundStyle(.gray)
            .padding()
    }
}

struct Cards: View {
    let cuisine: String
    var restaurants: [Restaurant]
    let location: String
    var restaurantList: [Restaurant]
    
    var body: some View {
        
        if !restaurantList.isEmpty {
            Divider()
            
            Text(cuisine)
                .font(.title.bold())
                .padding([.horizontal, .top])
        }
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(restaurantList) { restaurant in
                    NavigationLink {
                        IndividualRestaurantView(restaurant: restaurant)
                    } label: {
                        VStack {
                            ZStack {
                                Image(restaurant.restaurantThumbnail)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 200, height: 100)
                                    .clipped() // Clip content within frame
                                    .cornerRadius(10)
                                    .shadow(radius: 3)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.green, lineWidth: 1)
                                    )
                                
                                VStack {
                                    Spacer()
                                    HStack {
                                        Spacer()
                                        Image(restaurant.image)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 50)
                                            .background(Color.white)
                                            .clipShape(Circle())
                                            .padding(5)
                                    }
                                }
                            }
                            
                            HStack {
                                Text(restaurant.name)
                                    .font(.system(size: 18))
                                    .foregroundStyle(.black)
                                    .lineLimit(2)
                                    .truncationMode(.tail)
                                    .padding(.horizontal, 10)
                                    .multilineTextAlignment(.leading)
                                
                                Spacer()
                                
                                ZStack {
                                    let percentage = Double(restaurant.menu.safeItems) / Double(restaurant.menu.totalItems)
                                    let color = Color(red: (1 - percentage), green: percentage, blue: 0)
                                    Circle()
                                        .stroke(lineWidth: 5)
                                        .opacity(0.3)
                                        .foregroundColor(.gray)
                                        .frame(width: 40, height: 40)
                                    
                                    Circle()
                                        .trim(from: 0.0, to: percentage)
                                        .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                                        .foregroundColor(color)
                                        .rotationEffect(Angle(degrees: -90))
                                        .animation(.linear, value: percentage)
                                        .frame(width: 40, height: 40)
                                    
                                    Text(percentage, format: .percent.precision(.fractionLength(0)))
                                        .foregroundStyle(.white)
                                }
                                .padding(5)
                            }
                            .frame(maxWidth: 200)
                        }
                        .background(.green)
                        .clipShape(.rect(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.green)
                        )
                        .padding(.horizontal, 10)
                    }
                }
            }
        }
    }
    init(cuisine: String, restaurants: [Restaurant], location: String) {
        self.cuisine = cuisine
        self.restaurants = restaurants
        self.location = location
        
        self.restaurantList = cuisine == "Favourites" ? restaurants.filter{User.shared.userProfile.favouriteRestaurants[$0.name] ?? false} : restaurants.filter{$0.cuisine==cuisine}
        if !(location == "All"){
            restaurantList = restaurantList.filter{$0.location==location}
        }
    }
}

struct FilterPickerView: View {
    @Binding var selectedLocation: String
    @Environment(\.dismiss) var dismiss
    let options: [String]
    let topic: String

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button("Done") {
                    dismiss()
                }
                .padding()
            }
            List {
                ForEach(options, id: \.self) { option in
                    Button(action: {
                        selectedLocation = option
                    }) {
                        HStack {
                            Text(option)
                            if selectedLocation == option {
                                Spacer()
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
            }
            .navigationTitle("Select \(topic)")
        }
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
    }
}


struct MainPageView: View {
    let restaurants: [Restaurant] = Bundle.main.decode("restaurants.json")
    let cuisines = ["Asian", "Italian", "Tapas", "Steakhouse", "Bar & Grill", "Mexican"]
    
    @State private var showingLocationFilter = false
    @State private var locationFilter = "All"
    private let locationOptions = ["All", "Kingston", "Toronto"]
    
    @State private var showingCuisineFilter = false
    @State private var cuisineFilter = "All"
    
    @State private var searchQuery = ""
    @FocusState private var searchIsFocused: Bool

    var filteredRestaurants: [Restaurant] {
        if searchQuery.isEmpty {
            return restaurants
        } else {
            return restaurants.filter { $0.name.localizedCaseInsensitiveContains(searchQuery) }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    VStack {
                        if (User.shared.userProfile.favouriteRestaurants.values.contains(true)) {
                            VStack(alignment: .leading) {
                                
                                Cards(cuisine: "Favourites", restaurants: restaurants, location: "All")
                                
                                Divider()
                            }
                        }
                        
                        HStack {
                            TextField("Search for restaurants", text: $searchQuery)
                                .padding(.leading, 24)
                                .focused($searchIsFocused)
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.horizontal)
                        
                        HStack(alignment: .center){
                            VStack {
                                Text("Filters")
                                    .font(.headline)
                                    .padding(.horizontal)
                                
                                Spacer()
                            }
                            
                            Spacer ()
                            
                            Button(action: {
                                withAnimation{
                                    locationFilter = "All"
                                    cuisineFilter = "All"
                                }
                            }) {
                                Text("Reset")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .padding(10)
                                    .background(Color.clear)
                                    .cornerRadius(30)
                                    .overlay(
                                        Capsule()
                                            .stroke(Color.gray, lineWidth: 2)
                                    )
                            }
                            .padding(.horizontal)
                        }
                        .padding(.top)
                        
                        HStack (alignment: .top) {
                            Button {
                                showingLocationFilter.toggle()
                            } label: {
                                Text("Location: \(locationFilter)")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.green)
                                    .cornerRadius(30)
                                    .shadow(color: .gray, radius: 2, x: 0, y: 2)
                            }
                            .padding(10)
                            
                            Button {
                                showingCuisineFilter.toggle()
                            } label: {
                                Text("Cuisine: \(cuisineFilter)")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.green)
                                    .cornerRadius(30)
                                    .shadow(color: .gray, radius: 2, x: 0, y: 2)
                            }
                            .padding(10)
                            
                            Spacer()
                        }
                        VStack(alignment: .leading) {
                            if cuisineFilter == "All" {
                                ForEach(cuisines, id:\.self) { cuisine in
                                    Cards(cuisine: cuisine, restaurants: filteredRestaurants, location: locationFilter)
                                }
                            } else {
                                Cards(cuisine: cuisineFilter, restaurants: filteredRestaurants, location: locationFilter)
                            }
                        }
                    }
                    
                }
                .navigationTitle("Restaurants")
                
                .sheet(isPresented: $showingLocationFilter) {
                    FilterPickerView(selectedLocation: $locationFilter, options: locationOptions, topic: "Location")
                }
                .sheet(isPresented: $showingCuisineFilter) {
                    FilterPickerView(selectedLocation: $cuisineFilter, options: cuisines, topic: "Cuisine")
                }
                .toolbar {
                    if searchIsFocused {
                        Button("Done") {
                            searchIsFocused = false
                        }
                    }
                }
                .toolbarBackground(.green)
                .navigationBarBackButtonHidden(true)
            }
        }
    }
}

struct MapPageView: View {
    @State private var restaurants: [Restaurant] = []

    init() {
        let restaurants: [Restaurant] = Bundle.main.decode("restaurants.json")
        _restaurants = State(initialValue: restaurants)
    }

    var body: some View {
        VStack {
            MapViewMultiple(restaurants: $restaurants)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct ContentView: View {
    var body: some View {
        TabView {
            MainPageView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Restaurants")
                }
            
            MapPageView()
                .tabItem{
                    Image(systemName: "map.fill")
                    Text("Map")
                }
            
            UserProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
        .navigationBarBackButtonHidden(true)
    }
    init() {
        User.shared.userProfile.userProfileMade = true
    }
}

#Preview {
    ContentView()
}
