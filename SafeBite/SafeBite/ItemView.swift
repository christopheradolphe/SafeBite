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
        VStack(alignment: .leading) {
            Text(menuItem.name)
                .font(.title.bold())
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
