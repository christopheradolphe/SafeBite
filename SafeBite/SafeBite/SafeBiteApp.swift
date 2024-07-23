//
//  SafeBiteApp.swift
//  SafeBite
//
//  Created by Christopher Adolphe on 2024-06-02.
//

import SwiftUI

@main
struct SafeBiteApp: App {
    @State private var isLoggedIn: Bool = User.shared.userProfile.userProfileMade
    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                SignInView()
            } else {
                ContentView()
            }
        }
    }
}
