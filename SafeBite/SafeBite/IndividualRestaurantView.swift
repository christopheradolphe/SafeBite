//
//  IndividualRestaurantView.swift
//  SafeBite
//
//  Created by Christopher Adolphe on 2024-06-02.
//

import SwiftUI

struct IndividualRestaurantView: View {
    let menu: Menu
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
    init(restaurant: String) {
        let filename = restaurant + ".json"
        self.menu = Menu(menuItems: Bundle.main.decode(filename))
    }
}

#Preview {
    IndividualRestaurantView(restaurant: "missbao")
}
