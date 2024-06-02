//
//  ContentView.swift
//  SafeBite
//
//  Created by Christopher Adolphe on 2024-06-02.
//

import SwiftUI

struct ContentView: View {
    let restaurants: [Restaurant] = Bundle.main.decode("restaurants.json")
    
    var body: some View {
        ForEach(restaurants) { restaurant in
            Image(restaurant.image)
        }
    }
}

#Preview {
    ContentView()
}
