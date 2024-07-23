//
//  ItemView.swift
//  SafeBite
//
//  Created by Christopher Adolphe on 2024-06-11.
//

import SwiftUI

struct AllergenCards: View {
    var safetyIndicator: Int
    var allergens: Bool //true-> allergens; false -> Dietary Restrictions
    let menuItem: MenuItem
    
    var color: Color {
        switch safetyIndicator {
        case 0:
            return .green
        case 1:
            return .orange
        default:
            return .red
        }
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                if allergens {
                    ForEach(menuItem.allergenInfo.keys.filter{menuItem.allergenInfo[$0] == safetyIndicator}, id: \.self) { allergen in
                        Text(allergen)
                            .foregroundStyle(.white)
                            .padding(10)
                            .background(color)
                            .clipShape(.capsule)
                            .padding(.leading, 3)
                    }
                } else {
                    ForEach(menuItem.dietaryRestrictionInfo.keys.filter{menuItem.dietaryRestrictionInfo[$0] == safetyIndicator}, id: \.self) { dietaryRestriction in
                        Text(dietaryRestriction)
                            .foregroundStyle(.white)
                            .padding(10)
                            .background(color)
                            .clipShape(.capsule)
                            .padding(.leading, 5)
                    }
                }
            }
        }
    }
}

struct ItemViewOld: View {
    private var menuItem: MenuItem
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack (alignment: .leading) {
                    Text("Item Information")
                        .font(.title2)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical)
                    
                    HStack {
                        Text("Menu Item:")
                        Spacer()
                        Text(menuItem.name)
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        Text("Menu Type:")
                        Spacer()
                        Text(menuItem.itemType)
                    }
                    .padding(.horizontal)
                    
                    if menuItem.description != "" {
                        Text("Item Description:")
                            .padding()
                        Spacer()
                        
                        Text(menuItem.description)
                        .padding(.horizontal)
                    }
                }
                
                Separator()
                
                VStack(alignment: .leading) {
                    Text("Dietary Restrictions")
                        .font(.title2)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    Text("Matches")
                        .font(.title3)
                        .padding()
                    AllergenCards(safetyIndicator: 0, allergens: false, menuItem: menuItem)
                    Text("With Changes")
                        .font(.title3)
                        .padding()
                    AllergenCards(safetyIndicator: 1, allergens: false, menuItem: menuItem)
                    Text("Not Suitable")
                        .font(.title3)
                        .padding()
                    AllergenCards(safetyIndicator: 2, allergens: false, menuItem: menuItem)
                    
                    Separator()
                }
                
                VStack(alignment: .leading) {
                    Text("Allergens")
                        .font(.title2)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    Text("Allergen Safe")
                        .font(.title3)
                        .padding()
                    AllergenCards(safetyIndicator: 0, allergens: true, menuItem: menuItem)
                    Text("Allergen Removal Possible")
                        .font(.title3)
                        .padding()
                    AllergenCards(safetyIndicator: 1, allergens: true, menuItem: menuItem)
                    Text("Contains Allergen")
                        .font(.title3)
                        .padding()
                    AllergenCards(safetyIndicator: 2, allergens: true, menuItem: menuItem)
                }
            }
            .navigationTitle(menuItem.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    init(menuItem: MenuItem) {
        self.menuItem = menuItem
    }
}

struct ItemView: View {
    private var menuItem: MenuItem
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
                
                VStack(alignment: .leading) {
                    
                    Text("Diets Not Suitable")
                        .font(.title3)
                        .padding(.horizontal)
                    
                    // List all diets not suitable for the dish
                    AllergenCards(safetyIndicator: 2, allergens: false, menuItem: menuItem)
                    
                    Separator()
                    
                    Text("Allergens Contained")
                        .font(.title3)
                        .padding(.horizontal)
                    
                    // List all allergens contained in the dish
                    AllergenCards(safetyIndicator: 2, allergens: true, menuItem: menuItem)
                    
                    Button(action: {
                        dismiss()
                    }) {
                        Text("OKAY")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.top)
                }
            
            .navigationTitle(menuItem.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    init(menuItem: MenuItem) {
        self.menuItem = menuItem
    }
}

#Preview {
    let menu: Menu = Menu(menuItems: Bundle.main.decode("missbao.json"))
    return ItemView(menuItem: menu.menuItems[0])
}
