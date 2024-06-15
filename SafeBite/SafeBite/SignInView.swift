//
//  SignInView.swift
//  SafeBite
//
//  Created by Christopher Adolphe on 2024-06-11.
//

import SwiftUI

struct SignInView: View {
    @State private var user = User()
    
    var body: some View {
        NavigationStack {
            Form {
                Section ("Personal Information"){
                    TextField("First Name", text: $user.userProfile.userInformation.firstName)
                    TextField("Last Name", text: $user.userProfile.userInformation.lastName)
                    TextField("Email", text: $user.userProfile.userInformation.email)
                    TextField("Phone Number", text: $user.userProfile.userInformation.phoneNumber)
                }
                
                Section ("Dietary Restrictions") {
                    Toggle("Vegetarian", isOn: $user.userProfile.dietaryRestrictions.vegetarian)
                    Toggle("Vegan", isOn: $user.userProfile.dietaryRestrictions.vegan)
                    Toggle("Halal", isOn: $user.userProfile.dietaryRestrictions.halal)
                    Toggle("Keto", isOn: $user.userProfile.dietaryRestrictions.keto)
                    Toggle("Low-Carb (50-150g of carbs)", isOn: $user.userProfile.dietaryRestrictions.lowCarb)
                    Toggle("Low FODMAP", isOn: $user.userProfile.dietaryRestrictions.lowFODMAP)
                    Toggle("Dash Diet", isOn: $user.userProfile.dietaryRestrictions.dashDiet)
                }
                
                Section ("Allergies") {
                    Toggle("Wheat", isOn: $user.userProfile.allergens.wheat)
                    Toggle("Gluten", isOn: $user.userProfile.allergens.gluten)
                    Toggle("Soy", isOn: $user.userProfile.allergens.soy)
                    Toggle("Shellfish", isOn: $user.userProfile.allergens.shellfish)
                    Toggle("Fish", isOn: $user.userProfile.allergens.fish)
                    Toggle("Dairy", isOn: $user.userProfile.allergens.dairy)
                    Toggle("Egg", isOn: $user.userProfile.allergens.egg)
                    Toggle("Tree Nuts", isOn: $user.userProfile.allergens.treeNuts)
                    Toggle("Peanuts", isOn: $user.userProfile.allergens.peanuts)
                    Toggle("Sesame", isOn: $user.userProfile.allergens.sesame)
                    Toggle("Mustard", isOn: $user.userProfile.allergens.mustard)
                    Toggle("Garlic", isOn: $user.userProfile.allergens.garlic)
                    Toggle("Sulfites", isOn: $user.userProfile.allergens.sulfites)
                }
                
                NavigationLink {
                    ContentView()
                } label: {
                    VStack {
                        Text("Submit Profile")
                    }
                }
                .disabled(user.userProfile.userInformation.invalidUserInformation)
            }
            
            .navigationTitle("SafeBite Profile")
        }
    }
}

#Preview {
    SignInView()
}
