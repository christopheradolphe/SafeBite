//
//  ContentView.swift
//  SafeBite
//
//  Created by Christopher Adolphe on 2024-06-02.
//

import SwiftUI
import CoreLocation
import MapKit

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
                                    .frame(width: 250, height: 100)
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
                                VStack (alignment: .leading){
                                    Text(restaurant.name)
                                        .font(.system(size: 18))
                                        .foregroundStyle(.black)
                                        .lineLimit(1)
                                        .multilineTextAlignment(.leading)
                                    Text(restaurant.address)
                                        .font(.system(size: 10))
                                        .foregroundStyle(.black)
                                        .lineLimit(1)
                                        .multilineTextAlignment(.leading)
                                }
                                
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
                            .frame(maxWidth: 230)
                        }
                        .background(.green)
                        .clipShape(.rect(cornerRadius: 10))
                        .shadow(radius: 5)
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
        
        switch cuisine {
        case "Favourites":
            self.restaurantList = restaurants.filter {
                User.shared.userProfile.favouriteRestaurants[$0.name] ?? false
            }
            
        case "Safest":
            self.restaurantList = restaurants
                .sorted {
                    let firstPercentage = Double($0.menu.safeItems) / Double($0.menu.totalItems)
                    let secondPercentage = Double($1.menu.safeItems) / Double($1.menu.totalItems)
                    return firstPercentage > secondPercentage
                }
                .prefix(5)
                .map { $0 }
            
        case "Closest":
            // Safely unwrap the user's location before calculating distances
            self.restaurantList = []
        default:
            self.restaurantList = restaurants.filter { $0.cuisine == cuisine }
        }
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
                        // Display Favourites Section if Available
                        if (User.shared.userProfile.favouriteRestaurants.values.contains(true)) {
                            VStack(alignment: .leading) {
                                Cards(cuisine: "Favourites", restaurants: restaurants, location: "All")
                                Divider()
                            }
                            .padding(.bottom, 10)
                        }
                        
                        // Display Top 5 Safest Restaurants Section
                        VStack(alignment: .leading) {
                            Cards(cuisine: "Safest", restaurants: restaurants, location: "All")
                        }
                        .padding(.bottom, 10)
                        
                        VStack(alignment: .leading) {
                            Cards(cuisine: "Closest", restaurants: restaurants, location: "All")
                        }
                        .padding(.bottom, 10)
                        
                        // Search Bar
                        HStack {
                            TextField("Search for restaurants", text: $searchQuery)
                                .padding(.leading, 24)
                                .focused($searchIsFocused)
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.horizontal)
                        
                        // Filters Section
                        HStack(alignment: .center) {
                            VStack {
                                Text("Filters")
                                    .font(.headline)
                                    .padding(.horizontal)
                                Spacer()
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                withAnimation {
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
                        
                        // Location and Cuisine Filter Buttons
                        HStack(alignment: .top) {
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
                            .padding(.horizontal, 10)
                            
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
                            .padding(.horizontal, 10)
                            
                            Spacer()
                        }
                        .padding(.bottom, 10)
                        
                        // Display Cuisine Cards
                        VStack(alignment: .leading) {
                            if cuisineFilter == "All" {
                                ForEach(cuisines, id: \.self) { cuisine in
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
                    // Centered App Icon in Navigation Bar
                    ToolbarItem(placement: .principal) {
                        Image("safebite")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 35)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .clipped()
                            .padding(.top, 5)
                    }
                    
                    // Done Button for Keyboard Focus
                    if searchIsFocused {
                        ToolbarItem(placement: .keyboard) {
                            Button("Done") {
                                searchIsFocused = false
                            }
                        }
                    }
                }
                .toolbarBackground(Color.green, for: .navigationBar) // Set consistent toolbar background color
                .navigationBarBackButtonHidden(true)
            }
        }
    }
}

struct MapPageView: View {
    @State private var restaurants: [Restaurant] = []
    @StateObject private var locationManager = LocationManager()
    @State private var selectedRestaurant: Restaurant? // State to hold the selected restaurant

    init() {
        let restaurants: [Restaurant] = Bundle.main.decode("restaurants.json")
        _restaurants = State(initialValue: restaurants)
    }

    var body: some View {
        VStack {
            MapViewMultiple(restaurants: $restaurants, selectedRestaurant: $selectedRestaurant)
                .edgesIgnoringSafeArea(.all)
                .onAppear {
                    if let mapView = UIApplication.shared.windows.first?.rootViewController?.view.subviews.first(where: { $0 is MKMapView }) as? MKMapView {
                        setInitialRegion(for: mapView)
                    }
                }
                .sheet(item: $selectedRestaurant) { restaurant in
                    // Display the restaurant information in a sheet
                    RestaurantDetailSheet(restaurant: restaurant)
                        .presentationDetents([.medium])
                }
        }
    }

    private func setInitialRegion(for mapView: MKMapView) {
        if let userLocation = locationManager.userLocation {
            let region = MKCoordinateRegion(
                center: userLocation.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
            mapView.setRegion(region, animated: true)
        }
    }
}

struct RestaurantDetailSheet: View {
    let restaurant: Restaurant
    @State private var navigateToRestaurant = false // State to trigger navigation
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView { // Wrap in a NavigationView to enable navigation within the sheet
            VStack(alignment: .leading, spacing: 16) {
                HStack(alignment: .top, spacing: 16) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(restaurant.name)
                            .font(.title)
                            .fontWeight(.bold)

                        Text(restaurant.address)
                            .font(.subheadline)
                    }

                    Spacer()

                    // Display restaurant image on the right side
                    Image(restaurant.image) // Replace with the correct property or method to get the image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80) // Adjust the size as needed
                        .cornerRadius(8)
                }

                Text(restaurant.description)
                    .font(.body)
                    .padding(.top, 8)
                    .lineLimit(3)

                // NavigationLink combined with a button style for a seamless experience
                NavigationLink(
                    destination: IndividualRestaurantView(restaurant: restaurant),
                    isActive: $navigateToRestaurant // Binding to trigger navigation
                ) {
                    HStack {
                        Text("Go to Restaurant")
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
            }
            .padding()
            .toolbar {
                // Add a dismiss button in the top right corner
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        dismiss() // Dismiss the view when the button is tapped
                    }) {
                        Image(systemName: "xmark") // SF Symbol for an "X" icon
                            .foregroundColor(.black) // Adjust color as needed
                    }
                }
            }
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
