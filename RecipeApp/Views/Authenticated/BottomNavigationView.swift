//
//  BottomNavigationView.swift
//  RecipeApp
//
//  Created by Elin Pettersson on 2022-11-07.
//

import SwiftUI

struct BottomNavigationView: View {
    
    @EnvironmentObject var dbConnection: DatabaseConnection
    
    var body: some View {
        
        VStack {
            NavigationStack {
                HStack(alignment: .bottom)  {
                    Spacer()
                    
                    ZStack {
                        
                        NavigationLink(destination: FavouriteView(), label: {
                            Circle().frame(width: 80).foregroundColor(.brown)
                        })
                        Image(systemName: "star.fill").resizable().frame(width: 25, height: 25).foregroundColor(.white)
                    }
                    
                    Spacer()
                }
                Button(action: {
                    dbConnection.SignOut()
                }, label: {
                    Text("Sign out").foregroundColor(.black)
                })
            }
            
            
        }
    }
}

struct BottomNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        BottomNavigationView()
    }
}
