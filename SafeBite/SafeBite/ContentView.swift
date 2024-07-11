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
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                let restaurantList = cuisine == "Favourites" ? restaurants.filter{User.shared.userProfile.favouriteRestaurants[$0.name] ?? false} : restaurants.filter{$0.cuisine==cuisine}
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


struct ContentView: View {
    let restaurants: [Restaurant] = Bundle.main.decode("restaurants.json")
    let cuisines = ["Asian", "Italian", "Tapas", "Steakhouse", "Bar & Grill", "Mexican", "Steakhouse"]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    VStack(alignment: .leading) {
                        Text("Favourites")
                            .font(.title.bold())
                            .padding([.horizontal, .top])
                        
                        if (!User.shared.userProfile.favouriteRestaurants.values.contains(true)) {
                                Text("You Currently Have No Favourite Restaurants")
                                    .font(.callout)
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.center) // Center-align the text if it's multiline
                                    .frame(maxWidth: .infinity, maxHeight: .infinity) // Expand to fill the parent view
                                    .background(Color.clear) // Ensure background is clear to center properly
                                    .padding(.vertical)

                        }
                        
                        Cards(cuisine: "Favourites", restaurants: restaurants)
                        
                        Divider()
                    }
                        ForEach(cuisines, id:\.self) { cuisine in
                        VStack(alignment: .leading) {
                            Text(cuisine)
                                .font(.title.bold())
                                .padding([.horizontal, .top])

                            Cards(cuisine: cuisine, restaurants: restaurants)
                            
                            Divider()
                        }
                    }
                }
                
            }
            .navigationTitle("Restaurants")
            .toolbarBackground(.green)
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    ContentView()
}
