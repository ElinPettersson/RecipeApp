//
//  ContentView.swift
//  RecipeApp
//
//  Created by Elin Pettersson on 2022-10-27.
//

import SwiftUI
import Firebase
import Foundation

struct ContentView: View {
    
    @EnvironmentObject var dbConnection: DatabaseConnection
    
    
    
    
    var body: some View {
        
        if dbConnection.userLoggedIn {
            
            NavigationStack {
                
                    RecipeListView()
                
            }
            
        } else {
            NavigationStack {
                SignInView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            ContentView().environmentObject(DatabaseConnection())
        }
    }
}
