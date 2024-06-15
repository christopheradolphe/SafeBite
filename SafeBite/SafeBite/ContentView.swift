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
    let restaurants: [Restaurant]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(restaurants.filter{$0.cuisine==cuisine}) { restaurant in
                    NavigationLink {
                        IndividualRestaurantView(restaurant: restaurant)
                    } label: {
                        VStack {
                            Image(restaurant.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()
                            VStack {
                                Text(restaurant.name)
                                    .font(.subheadline)
                                    .foregroundStyle(.white)
                                    .frame(maxWidth: 100)
                            }
                            .frame(maxWidth: .infinity)
                            .background(.blue)
                        }
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
                            
                            Separator()
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
