//
//  FavouriteView.swift
//  RecipeApp
//
//  Created by Elin Pettersson on 2022-11-07.
//

import SwiftUI

struct FavouriteView: View {
    
    @EnvironmentObject var dbConnection: DatabaseConnection
    
    var body: some View {
        VStack {
            VStack {
                Text("Your favourite recipes").bold().font(.title)

            }.padding().frame(height: 130, alignment: .center)
            
            Spacer()
            
            ScrollView {

                ForEach(dbConnection.favRecipes, id: \.self) { recipe in
                        NavigationLink(destination: RecipeView(recipe: recipe), label: {
                            RecipeCard(recipe: recipe)
                        })
                    
                }
                
                
                
            }.padding()
            
        }
        
        
    }
                                    
 }
                              

struct FavouriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteView()
    }
}
