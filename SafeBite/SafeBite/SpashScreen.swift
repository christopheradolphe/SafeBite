//
//  SpashScreen.swift
//  SafeBite
//
//  Created by Christopher Adolphe on 2024-07-23.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isAnimating = false
    
    var body: some View {
        VStack {
            Image("safebite")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 25))                .scaleEffect(isAnimating ? 1.1 : 1.0) // Pulsing effect
                .animation(
                    Animation.easeInOut(duration: 0.75)
                        .repeatForever(autoreverses: true)
                )
                .onAppear {
                    isAnimating = true
                }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
}

#Preview {
    return SplashScreenView()
}
