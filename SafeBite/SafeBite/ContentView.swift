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

struct ContentView: View {
    let restaurants: [Restaurant] = Bundle.main.decode("restaurants.json")
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    VStack(alignment: .leading) {
                        Text("Asian")
                            .font(.title.bold())
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(restaurants) { restaurant in
                                    NavigationLink {
                                        Text("Entering restaurant")
                                    } label: {
                                        VStack {
                                            Image(restaurant.image)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 100, height: 100)
                                        }
                                    }
                                }
                            }
                        }
                        
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
