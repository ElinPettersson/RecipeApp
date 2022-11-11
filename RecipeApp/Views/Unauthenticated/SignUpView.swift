//
//  SignUpView.swift
//  RecipeApp
//
//  Created by Elin Pettersson on 2022-11-02.
//

import SwiftUI
import Foundation
import Firebase

struct SignUpView: View {
    var db = Firestore.firestore()
    
    @EnvironmentObject var dbConnection: DatabaseConnection
    
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        
        VStack(spacing: 30) {
            
            Text("Register an account").bold().font(.title)
            
            VStack(alignment: .leading) {
                Text("Email")
                TextField("", text: $email).textFieldStyle(.roundedBorder)
                
                Text("Password")
                SecureField("", text: $password).textFieldStyle(.roundedBorder)
            }.padding().padding()
            
            Button("Register") {
                dbConnection.RegisterUser(email: email, password: password)
            }.buttonStyle(.borderedProminent).background(.brown)
            
            
        }.padding()
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            SignUpView()
        }
    }
}
