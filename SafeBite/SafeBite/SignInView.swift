//
//  SignInView.swift
//  SafeBite
//
//  Created by Christopher Adolphe on 2024-06-11.
//

import SwiftUI

struct SignInView: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var phoneNumber = ""
    
    @State private var vegetarian = false
    @State private var vegan = false
    
    @State private var peanuts = false
    @State private var sesame = false
    var body: some View {
        NavigationStack {
            Form {
                Section ("Personal Information"){
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
                    TextField("Email", text: $email)
                    TextField("Phone Number", text: $phoneNumber)
                }
                
                Section ("Dietary Restrictions") {
                    Toggle("Vegetarian", isOn: $vegetarian)
                    Toggle("Vegan", isOn: $vegan)
                }
                
                Section ("Allergies") {
                    Toggle("Peanuts", isOn: $peanuts)
                    Toggle("Sesame", isOn: $sesame)
                }
            }
            .navigationTitle("SafeBite Profile")
        }
    }
}

#Preview {
    SignInView()
}
