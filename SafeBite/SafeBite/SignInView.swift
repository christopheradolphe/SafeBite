//
//  SignInView.swift
//  SafeBite
//
//  Created by Christopher Adolphe on 2024-06-11.
//

import SwiftUI

struct SignInView: View {
    @State private var user = User.shared
    @Environment(\.dismiss) var dismiss
    
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
                
                if !user.userProfile.userProfileMade {
                    NavigationLink {
                        ContentView()
                    } label: {
                        VStack {
                            Text("Submit Profile")
                        }
                    }
                    .disabled(user.userProfile.userInformation.invalidUserInformation)
                } else {
                    Button(action: {
                        dismiss()
                    }) {
                        VStack {
                            Text("Update Profile")
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                    }
                    .padding()
                    .disabled(user.userProfile.userInformation.invalidUserInformation)
                }
            }
            
            .navigationTitle("SafeBite Profile")
        }
    }
}

struct UserProfileView: View {
    @State private var user = User.shared
    @State private var showEditProfilePage = false

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("Personal Information")
                    .font(.headline)
                    .padding(.bottom, 5)

                Text("First Name: \(user.userProfile.userInformation.firstName)")
                Text("Last Name: \(user.userProfile.userInformation.lastName)")
                Text("Email: \(user.userProfile.userInformation.email)")
                Text("Phone Number: \(user.userProfile.userInformation.phoneNumber)")

                Divider()

                Text("Dietary Restrictions")
                    .font(.headline)
                    .padding(.bottom, 5)

                dietaryRestrictionsView

                Divider()

                Text("Allergies")
                    .font(.headline)
                    .padding(.bottom, 5)

                allergiesView

                Spacer()
                
                Button(action: {
                    user.userProfile.userProfileMade = true
                    showEditProfilePage = true
                }) {
                    Text("Edit Profile")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .sheet(isPresented: $showEditProfilePage) {
                    SignInView()
                }
                .padding()
            }
            .padding()
            .navigationTitle("Profile Summary")
        }
    }

    private var dietaryRestrictionsView: some View {
        VStack(alignment: .leading, spacing: 5) {
            if user.userProfile.dietaryRestrictions.vegetarian { Text("Vegetarian") }
            if user.userProfile.dietaryRestrictions.vegan { Text("Vegan") }
            if user.userProfile.dietaryRestrictions.halal { Text("Halal") }
            if user.userProfile.dietaryRestrictions.keto { Text("Keto") }
            if user.userProfile.dietaryRestrictions.lowCarb { Text("Low-Carb (50-150g of carbs)") }
            if user.userProfile.dietaryRestrictions.lowFODMAP { Text("Low FODMAP") }
            if user.userProfile.dietaryRestrictions.dashDiet { Text("Dash Diet") }
        }
    }

    private var allergiesView: some View {
        VStack(alignment: .leading, spacing: 5) {
            if user.userProfile.allergens.wheat { Text("Wheat") }
            if user.userProfile.allergens.gluten { Text("Gluten") }
            if user.userProfile.allergens.soy { Text("Soy") }
            if user.userProfile.allergens.shellfish { Text("Shellfish") }
            if user.userProfile.allergens.fish { Text("Fish") }
            if user.userProfile.allergens.dairy { Text("Dairy") }
            if user.userProfile.allergens.egg { Text("Egg") }
            if user.userProfile.allergens.treeNuts { Text("Tree Nuts") }
            if user.userProfile.allergens.peanuts { Text("Peanuts") }
            if user.userProfile.allergens.sesame { Text("Sesame") }
            if user.userProfile.allergens.mustard { Text("Mustard") }
            if user.userProfile.allergens.garlic { Text("Garlic") }
            if user.userProfile.allergens.sulfites { Text("Sulfites") }
        }
    }
}

#Preview {
    SignInView()
}
