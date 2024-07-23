//
//  SpashScreen.swift
//  SafeBite
//
//  Created by Christopher Adolphe on 2024-07-23.
//

import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        VStack {
            Image("AppIcon")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
