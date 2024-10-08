//
//  ItemView.swift
//  SafeBite
//
//  Created by Christopher Adolphe on 2024-06-11.
//

import SwiftUI

extension String {
    func capitalizedFirstLetter() -> String {
        // Capitalize the first letter
        guard let firstLetter = self.first else {
            return self
        }
        let firstCapitalized = firstLetter.uppercased()
        let restOfString = self.dropFirst()
        
        // Add a space before each capital letter in the rest of the string
        let result = restOfString.reduce(into: firstCapitalized) { result, char in
            if char.isUppercase {
                result.append(" ")
            }
            result.append(char)
        }
        
        return result
    }
}

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
                    let allergenList = menuItem.allergenInfo.keys.filter{menuItem.allergenInfo[$0] == safetyIndicator}
                    if allergenList.isEmpty {
                        Text("N/A")
                            .foregroundStyle(color)
                            .padding(10)
                            .background(Color.white)
                            .clipShape(Capsule())
                            .padding(.leading, 3)
                            .overlay(
                                Capsule()
                                    .stroke(color, lineWidth: 1)
                            )
                    } else {
                        ForEach(allergenList, id: \.self) { allergen in
                            if User.shared.userProfile.allergens.allergenList.contains(allergen) {
                                Text(String(allergen).capitalizedFirstLetter())
                                    .foregroundStyle(.white)
                                    .padding(10)
                                    .background(color)
                                    .clipShape(.capsule)
                                    .padding(.leading, 3)
                            }
                        }
                        ForEach(allergenList, id: \.self) { allergen in
                            if !User.shared.userProfile.allergens.allergenList.contains(allergen) {
                                Text(String(allergen).capitalizedFirstLetter())
                                    .foregroundStyle(color)
                                    .padding(10)
                                    .background(Color.white)
                                    .clipShape(Capsule())
                                    .padding(.leading, 3)
                                    .overlay(
                                        Capsule()
                                            .stroke(color, lineWidth: 1)
                                    )
                            }
                        }
                    }
                } else {
                    let dietaryRestrictionList = menuItem.dietaryRestrictionInfo.keys.filter { menuItem.dietaryRestrictionInfo[$0] == safetyIndicator }
                    if dietaryRestrictionList.isEmpty {
                        Text("N/A")
                            .foregroundStyle(color)
                            .padding(10)
                            .background(Color.white)
                            .clipShape(Capsule())
                            .padding(.leading, 3)
                            .overlay(
                                Capsule()
                                    .stroke(color, lineWidth: 1)
                            )
                    } else {
                        ForEach(dietaryRestrictionList, id: \.self) { dietaryRestriction in
                            if User.shared.userProfile.allergens.allergenList.contains(dietaryRestriction) {
                                Text(String(dietaryRestriction).capitalizedFirstLetter())
                                    .foregroundStyle(.white)
                                    .padding(10)
                                    .background(color)
                                    .clipShape(.capsule)
                                    .padding(.leading, 3)
                            }
                        }
                        ForEach(dietaryRestrictionList, id: \.self) { dietaryRestriction in
                            if !User.shared.userProfile.allergens.allergenList.contains(dietaryRestriction) {
                                Text(String(dietaryRestriction).capitalizedFirstLetter())
                                    .foregroundStyle(color)
                                    .padding(10)
                                    .background(Color.white)
                                    .clipShape(Capsule())
                                    .padding(.leading, 3)
                                    .overlay(
                                        Capsule()
                                            .stroke(color, lineWidth: 1)
                                    )
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 10)
        }
        .padding(.vertical, 10)
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
    var menuItem: MenuItem
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationStack {
                
                VStack(alignment: .leading) {
                    
                    Text("Diets Not Suitable")
                        .font(.title3)
                        .padding(.horizontal)
                    
                    // List all diets not suitable for the dish
                    AllergenCards(safetyIndicator: 2, allergens: false, menuItem: menuItem)
                        .padding(.bottom, 20)
                    
                    Text("Allergens Contained")
                        .font(.title3)
                        .padding(.horizontal)
                    
                    // List all allergens contained in the dish
                    AllergenCards(safetyIndicator: 2, allergens: true, menuItem: menuItem)
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            isPresented = false
                        }) {
                            Text("OKAY")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .frame(width: UIScreen.main.bounds.width / 2)
                        Spacer()
                    }
                    .padding(.top)
                }
            
            .navigationTitle(menuItem.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    let menu: Menu = Menu(menuItems: Bundle.main.decode("missbao.json"))
    @State var test = false
    return ItemView(menuItem: menu.menuItems[0],isPresented: $test)
}
