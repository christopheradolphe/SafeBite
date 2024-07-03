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
                ForEach(restaurants.filter{$0.cuisine==cuisine}) { restaurant in
                    NavigationLink {
                        IndividualRestaurantView(restaurant: restaurant)
                    } label: {
                        VStack {
                            ZStack {
                                Image(restaurant.restaurantThumbnail)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width:150, height:100)
                                VStack {
                                    Spacer()
                                    HStack {
                                        Spacer()
                                        Image(restaurant.image)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width:50, height:50)
                                            .background(.white)
                                    }
                                }
                            }
                            HStack {
                                Text(restaurant.name)
                                    .font(.subheadline)
                                    .foregroundStyle(.black)
                                    .frame(maxWidth: 150)
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
                            .frame(maxWidth: .infinity)
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
