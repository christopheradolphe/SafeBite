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
    @State private var showSplashScreen = true

    var body: some Scene {
        WindowGroup {
            if showSplashScreen {
                SplashScreenView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation {
                                showSplashScreen = false
                            }
                        }
                    }
            } else {
                if isLoggedIn {
                    ContentView()
                } else {
                    SignInView()
                }
            }
        }
    }
}
