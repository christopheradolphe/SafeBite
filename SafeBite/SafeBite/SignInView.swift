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
                Section(header: Text("Personal Information")) {
                    // First Name Field
                    VStack(alignment: .leading) {
                        Text("First Name *") // Asterisk to indicate required field
                            .foregroundColor(.primary)
                        TextField("First Name", text: $user.userProfile.userInformation.firstName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(user.userProfile.userInformation.firstName.isEmpty ? Color.red : Color.clear, lineWidth: 1)
                            )
                    }
                    
                    // Last Name Field
                    VStack(alignment: .leading) {
                        Text("Last Name *")
                            .foregroundColor(.primary)
                        TextField("Last Name", text: $user.userProfile.userInformation.lastName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(user.userProfile.userInformation.lastName.isEmpty ? Color.red : Color.clear, lineWidth: 1)
                            )
                    }
                    
                    // Email Field
                    VStack(alignment: .leading) {
                        Text("Email *")
                            .foregroundColor(.primary)
                        TextField("Email", text: $user.userProfile.userInformation.email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.emailAddress)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(user.userProfile.userInformation.email.isEmpty ? Color.red : Color.clear, lineWidth: 1)
                            )
                    }
                    
                    // Phone Number Field
                    VStack(alignment: .leading) {
                        Text("Phone Number *")
                            .foregroundColor(.primary)
                        TextField("Phone Number", text: $user.userProfile.userInformation.phoneNumber)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.phonePad)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(user.userProfile.userInformation.phoneNumber.isEmpty ? Color.red : Color.clear, lineWidth: 1)
                            )
                    }
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
                    Section {
                        VStack(spacing: 16) { // Add spacing between button and hint
                            // Update Profile Button
                            Button {
                                dismiss()
                            } label: {
                                VStack {
                                    HStack {
                                        Spacer()
                                        Text("Update Profile")
                                            .foregroundColor(user.userProfile.userInformation.invalidUserInformation ? .gray : .blue)
                                        Spacer()
                                    }
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(8)
                            }
                            .disabled(user.userProfile.userInformation.invalidUserInformation)
                            .opacity(user.userProfile.userInformation.invalidUserInformation ? 0.6 : 1.0)
                        }
                        
                        // Hint Section for Invalid Information
                        if user.userProfile.userInformation.invalidUserInformation {
                            // Separate VStack for hint to make it look distinct
                            VStack {
                                Text("Please complete all required fields to enable updating your profile.")
                                    .font(.footnote)
                                    .foregroundColor(.red)
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .cornerRadius(8)
                            }
                            .padding([.leading, .trailing], 16) // Add padding to make it look well-positioned
                        }
                    }
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
                    .opacity(user.userProfile.userInformation.invalidUserInformation ? 0.6 : 1.0)
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
                                .foregroundColor(.greenApp)
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
                            .background(Color.greenApp)
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
                .toolbarBackground(Color.greenApp, for: .navigationBar)
                .background(Color.backgroundColor).ignoresSafeArea(edges: .all)
            }
        }
    }

    private var dietaryRestrictionsView: some View {
        VStack(alignment: .leading, spacing: 5) {
            if user.userProfile.dietaryRestrictions.vegetarian {
                HStack {
                    Text("• Vegetarian")
                    Spacer()
                }
                .padding(.vertical, 2)
            }
            if user.userProfile.dietaryRestrictions.vegan {
                HStack {
                    Text("• Vegan")
                    Spacer()
                }
                .padding(.vertical, 2)
            }
            if user.userProfile.dietaryRestrictions.halal {
                HStack {
                    Text("• Halal")
                    Spacer()
                }
                .padding(.vertical, 2)
            }
            if user.userProfile.dietaryRestrictions.keto {
                HStack {
                    Text("• Keto")
                    Spacer()
                }
                .padding(.vertical, 2)
            }
            if user.userProfile.dietaryRestrictions.lowCarb {
                HStack {
                    Text("• Low-Carb")
                    Spacer()
                }
                .padding(.vertical, 2)
            }
            if user.userProfile.dietaryRestrictions.lowFODMAP {
                HStack {
                    Text("• Low FODMAP")
                    Spacer()
                }
                .padding(.vertical, 2)
            }
            if user.userProfile.dietaryRestrictions.dashDiet {
                HStack {
                    Text("• Dash Diet")
                    Spacer()
                }
                .padding(.vertical, 2)
            }
        }
        .foregroundColor(.greenApp)
    }

    private var allergiesView: some View {
        VStack(alignment: .leading, spacing: 5) {
            if user.userProfile.allergens.wheat {
                HStack {
                    Text("• Wheat")
                    Spacer()
                }
                .padding(.vertical, 2)
            }
            if user.userProfile.allergens.gluten {
                HStack {
                    Text("• Gluten")
                    Spacer()
                }
                .padding(.vertical, 2)
            }
            if user.userProfile.allergens.soy {
                HStack {
                    Text("• Soy")
                    Spacer()
                }
                .padding(.vertical, 2)
            }
            if user.userProfile.allergens.shellfish {
                HStack {
                    Text("• Shellfish")
                    Spacer()
                }
                .padding(.vertical, 2)
            }
            if user.userProfile.allergens.fish {
                HStack {
                    Text("• Fish")
                    Spacer()
                }
                .padding(.vertical, 2)
            }
            if user.userProfile.allergens.dairy {
                HStack {
                    Text("• Dairy")
                    Spacer()
                }
                .padding(.vertical, 2)
            }
            if user.userProfile.allergens.egg {
                HStack {
                    Text("• Egg")
                    Spacer()
                }
                .padding(.vertical, 2)
            }
            if user.userProfile.allergens.treeNuts {
                HStack {
                    Text("• Tree Nuts")
                    Spacer()
                }
                .padding(.vertical, 2)
            }
            if user.userProfile.allergens.peanuts {
                HStack {
                    Text("• Peanuts")
                    Spacer()
                }
                .padding(.vertical, 2)
            }
            if user.userProfile.allergens.sesame {
                HStack {
                    Text("• Sesame")
                    Spacer()
                }
                .padding(.vertical, 2)
            }
            if user.userProfile.allergens.mustard {
                HStack {
                    Text("• Mustard")
                    Spacer()
                }
                .padding(.vertical, 2)
            }
            if user.userProfile.allergens.garlic {
                HStack {
                    Text("• Garlic")
                    Spacer()
                }
                .padding(.vertical, 2)
            }
            if user.userProfile.allergens.sulfites {
                HStack {
                    Text("• Sulfites")
                    Spacer()
                }
                .padding(.vertical, 2)
            }
        }
        .foregroundColor(.red)
    }

    private func InfoText(label: String, value: String) -> some View {
        HStack {
            Text("\(label):")
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading) // Align label to the left
            Text(value)
                .frame(maxWidth: .infinity, alignment: .trailing) // Align value to the right
        }
        .padding(.bottom, 2)
        .background(Color.white)
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
        .shadow(color: Color.gray.opacity(0.6), radius: 8, x: 0, y: 8)
    }
}

#Preview {
    UserProfileView()
}
