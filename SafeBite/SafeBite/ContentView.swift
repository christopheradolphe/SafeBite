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
            .foregroundStyle(.black)
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
                        Text("Entering restaurant \(restaurant.name)")
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
                            .background(.green)
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
    let cuisines = [
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    VStack(alignment: .leading) {
                        Text("Asian")
                            .font(.title.bold())
                            .padding([.horizontal, .top])
                        
                        Cards(cuisine: "Asian", restaurants: restaurants)
                        
                        Separator()
                    }
                    
                    VStack(alignment: .leading) {
                        Text("")
                            .font(.title.bold())
                            .padding([.horizontal, .top])
                        
                        Cards(cuisine: "Italian", restaurants: restaurants)
                        
                        Separator()
                    }
                    
                }
                
            }
            .navigationTitle("Restaurants")
        }
    }
}

#Preview {
    ContentView()
}
