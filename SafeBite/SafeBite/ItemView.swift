//
//  ItemView.swift
//  SafeBite
//
//  Created by Christopher Adolphe on 2024-06-11.
//

import SwiftUI

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
