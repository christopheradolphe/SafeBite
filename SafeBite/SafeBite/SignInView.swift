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
                
//                if !user.userProfile.userProfileMade {
                if user.userProfile.userProfileMade {
                    Button {
                        dismiss()
                    } label: {
                        VStack {
                            HStack {
                                Spacer()
                                Text("Update Profile")
                                Spacer()
                            }
                        }
                    }
                    .disabled(user.userProfile.userInformation.invalidUserInformation)
                } else {
                    NavigationLink {
                        ContentView()
                    } label: {
                        VStack {
                            HStack {
                                Spacer()
                                Text("Submit Profile")
                                Spacer()
                            }
                        }
                    }
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
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // App Icon
                    ZStack {
                        HStack {
                            Spacer()
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.blue)
                            Spacer()
                        }
                    }
                    
                    // Personal Information
                    SectionView(title: "Personal Information") {
                        InfoText(label: "First Name", value: user.userProfile.userInformation.firstName)
                        InfoText(label: "Last Name", value: user.userProfile.userInformation.lastName)
                        InfoText(label: "Email", value: user.userProfile.userInformation.email)
                        InfoText(label: "Phone Number", value: user.userProfile.userInformation.phoneNumber)
                    }
                    
                    // Dietary Restrictions
                    SectionView(title: "Dietary Restrictions") {
                        dietaryRestrictionsView
                    }
                    
                    // Allergies
                    SectionView(title: "Allergies") {
                        allergiesView
                    }
                    
                    Spacer()
                    
                    // Edit Profile Button
                    Button(action: {
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
                .navigationBarTitleDisplayMode(.inline)
                .background(Color(UIColor.systemGray6)) // Light gray background
                .ignoresSafeArea(edges: .all)
            }
        }
        .toolbar {
            // Centered App Icon in Navigation Bar
            ToolbarItem(placement: .principal) {
                Image("safebite")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 35)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .clipped()
                    .padding(.top, 5)
            }
        }
    }

    private var dietaryRestrictionsView: some View {
        VStack(alignment: .leading, spacing: 5) {
            if user.userProfile.dietaryRestrictions.vegetarian { Label("Vegetarian", systemImage: "leaf.fill") }
            if user.userProfile.dietaryRestrictions.vegan { Label("Vegan", systemImage: "leaf.fill") }
            if user.userProfile.dietaryRestrictions.halal { Label("Halal", systemImage: "hand.raised.fill") }
            if user.userProfile.dietaryRestrictions.keto { Label("Keto", systemImage: "bolt.fill") }
            if user.userProfile.dietaryRestrictions.lowCarb { Label("Low-Carb", systemImage: "flame.fill") }
            if user.userProfile.dietaryRestrictions.lowFODMAP { Label("Low FODMAP", systemImage: "leaf.fill") }
            if user.userProfile.dietaryRestrictions.dashDiet { Label("Dash Diet", systemImage: "heart.fill") }
        }
        .foregroundColor(.green)
    }

    private var allergiesView: some View {
        VStack(alignment: .leading, spacing: 5) {
            if user.userProfile.allergens.wheat { Label("Wheat", systemImage: "exclamationmark.triangle.fill") }
            if user.userProfile.allergens.gluten { Label("Gluten", systemImage: "exclamationmark.triangle.fill") }
            if user.userProfile.allergens.soy { Label("Soy", systemImage: "exclamationmark.triangle.fill") }
            if user.userProfile.allergens.shellfish { Label("Shellfish", systemImage: "exclamationmark.triangle.fill") }
            if user.userProfile.allergens.fish { Label("Fish", systemImage: "exclamationmark.triangle.fill") }
            if user.userProfile.allergens.dairy { Label("Dairy", systemImage: "exclamationmark.triangle.fill") }
            if user.userProfile.allergens.egg { Label("Egg", systemImage: "exclamationmark.triangle.fill") }
            if user.userProfile.allergens.treeNuts { Label("Tree Nuts", systemImage: "exclamationmark.triangle.fill") }
            if user.userProfile.allergens.peanuts { Label("Peanuts", systemImage: "exclamationmark.triangle.fill") }
            if user.userProfile.allergens.sesame { Label("Sesame", systemImage: "exclamationmark.triangle.fill") }
            if user.userProfile.allergens.mustard { Label("Mustard", systemImage: "exclamationmark.triangle.fill") }
            if user.userProfile.allergens.garlic { Label("Garlic", systemImage: "exclamationmark.triangle.fill") }
            if user.userProfile.allergens.sulfites { Label("Sulfites", systemImage: "exclamationmark.triangle.fill") }
        }
        .foregroundColor(.red)
    }

    private func InfoText(label: String, value: String) -> some View {
        HStack {
            Text("\(label):")
                .fontWeight(.bold)
            Text(value)
        }
        .padding(.bottom, 2)
    }
}

struct SectionView<Content: View>: View {
    let title: String
    let content: () -> Content

    init(title: String, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.content = content
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
                .padding(.bottom, 5)
            content()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 5)
    }
}

#Preview {
    UserProfileView()
}
