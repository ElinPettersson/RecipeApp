//
//  LoginView.swift
//  RecipeApp
//
//  Created by Elin Pettersson on 2022-11-07.
//

import SwiftUI
import Firebase
import Foundation

struct SignInView: View {
    
    @EnvironmentObject var dbConnection: DatabaseConnection
    
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        
        VStack(spacing: 30) {
            
            Text("Enter your credentials").bold().font(.title)
            
            VStack(alignment: .leading) {
                Text("Email")
                TextField("", text: $email).textFieldStyle(.roundedBorder)
                
                Text("Password")
                SecureField("", text: $password).textFieldStyle(.roundedBorder)
            }.padding().padding()
            
            Button("Login") {
                dbConnection.LoginUser(email: email, password: password)
            }.buttonStyle(.borderedProminent).background(.brown)
            
            NavigationLink(destination: SignUpView(), label: {
                Text("Register an account").foregroundColor(.black).bold()
            })
            
        }.padding()
        
        
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            SignInView()
        }
    }
}
