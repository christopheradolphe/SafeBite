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
    
    var color: Color {
        if safetyIndicator == 0{
            return .green
        }else if safetyIndicator == 1 {
            return .orange
        } else {
            return .red
        }
    }
    var body: some View {
        ScrollView(.horizontal) {
            VStack {
                Text("Hello")
                    .foregroundStyle(.white)
                    .padding()
            }
            .background(color)
            .clipShape(.capsule)
            .padding(.horizontal)
        }
    }
}

struct ItemView: View {
    private var menuItem: MenuItem
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Dietary Restrictions")
                        .font(.title2)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        .padding(.vertical)
                    Text("Safe")
                        .font(.title3)
                        .padding()
                    AllergenCards(safetyIndicator: 0, allergens: false)
                    Text("Uncertain")
                        .font(.title3)
                        .padding()
                    Text("Unsafe")
                        .font(.title3)
                        .padding()
                    
                    Separator()
                }
                
                VStack(alignment: .leading) {
                    Text("Allergens")
                        .font(.title2)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    Text("Safe (Does not Contain)")
                        .font(.title3)
                        .padding()
                    Text("May Contain/Cross Contamination Risk")
                        .font(.title3)
                        .padding()
                    Text("Unsafe (Contains Allergen)")
                        .font(.title3)
                        .padding()
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

#Preview {
    var menu: Menu = Menu(menuItems: Bundle.main.decode("missbao.json"))
    return ItemView(menuItem: menu.menuItems[0])
}
