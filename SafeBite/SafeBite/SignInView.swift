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
                    Toggle("Vegetarian", isOn: $user.userProfile.dietaryRestrictions.Vegetarian)
                    Toggle("Vegan", isOn: $user.userProfile.dietaryRestrictions.Vegan)
                }
                
                Section ("Allergies") {
                    Toggle("Peanuts", isOn: $user.userProfile.allergens.Peanuts)
                    Toggle("Sesame", isOn: $user.userProfile.allergens.Sesame)
                }
                
            }
            
            NavigationLink {
                ContentView()
            } label: {
                VStack {
                    Text("Submit Profile")
                        .foregroundStyle(.black)
                }
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .background(.gray)
            .navigationTitle("SafeBite Profile")
        }
    }
}

#Preview {
    SignInView()
}
