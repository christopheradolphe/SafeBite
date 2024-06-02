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
                        Text("Asian, Italian, Tapas, Steakhouse, BarAndGrill, Mexican")
                            .font(.title.bold())
                        
                        Separator()
                    }
                }
                
            }
            .navigationTitle("Restaurants")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}
