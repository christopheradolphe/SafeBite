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
    
    var body: some View {
        let restaurantList = cuisine == "Favourites" ? restaurants.filter{User.shared.userProfile.favouriteRestaurants[$0.name] ?? false} : restaurants.filter{$0.cuisine==cuisine}
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
                                    .font(.callout)
                                    .foregroundStyle(.black)
                                    .lineLimit(2)
                                    .truncationMode(.tail)
                                    .padding(.horizontal, 5)
                                
                                Spacer()
                                
                                ZStack {
                                    let percentage = Double(restaurant.menu.safeItems) / Double(restaurant.menu.totalItems)
                                    let color = Color(red: (1 - percentage), green: percentage, blue: 0)
                                    Circle()
                                        .stroke(lineWidth: 5)
                                        .opacity(0.3)
                                        .foregroundColor(.gray)
                                        .frame(width: 50, height: 50)
                                    
                                    Circle()
                                        .trim(from: 0.0, to: percentage)
                                        .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                                        .foregroundColor(color)
                                        .rotationEffect(Angle(degrees: -90))
                                        .animation(.linear, value: percentage)
                                        .frame(width: 50, height: 50)
                                    
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


struct ContentView: View {
    let restaurants: [Restaurant] = Bundle.main.decode("restaurants.json")
    let cuisines = ["Asian", "Italian", "Tapas", "Steakhouse", "Bar & Grill", "Mexican"]
    
    @State private var showingLocationFilter = false
    @State private var locationFilter = "All"
    private let locationOptions = ["All", "Kingston", "Toronto"]
    
    @State private var showingCuisineFilter = false
    @State private var cuisineFilter = "All"
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    VStack(alignment: .leading) {
                        Text("Your Favourites")
                            .font(.title.bold())
                            .padding([.horizontal, .top])
                        
                        if (!User.shared.userProfile.favouriteRestaurants.values.contains(true)) {
                                Text("You Currently Have No Favourite Restaurants")
                                    .font(.callout)
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.center)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .background(Color.clear)
                                    .padding(.vertical)

                        }
                        
                        Cards(cuisine: "Favourites", restaurants: restaurants, location: "All")
                        
                        Divider()
                    }
                    
                    HStack(alignment: .center){
                        VStack {
                            Text("Filters")
                                .font(.title3)
                                .padding(10)
                            
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
                                Cards(cuisine: cuisine, restaurants: restaurants, location: locationFilter)
                            }
                        } else {
                            Cards(cuisine: cuisineFilter, restaurants: restaurants, location: locationFilter)
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
            .toolbarBackground(.green)
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    ContentView()
}
