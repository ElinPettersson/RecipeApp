//
//  RecipeCard.swift
//  RecipeApp
//
//  Created by Elin Pettersson on 2022-11-07.
//

import SwiftUI

struct RecipeCard: View {
    
    @EnvironmentObject var dbConnection: DatabaseConnection
    
    @State var recipeInList = [Recipe]()
    
    var recipe: Recipe
    
    
    var body: some View {
        
        VStack {
            ZStack {
                AsyncImage(url: URL(string: recipe.image), content: {
                        image in
                        
                    image.resizable().opacity(0.8)
                        
                    }, placeholder: {
                        Text("Loading").foregroundColor(.white)
                    }).overlay(LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.01), Color.black]), startPoint: .center, endPoint: .bottom))
                    
                HStack {
                    VStack(alignment: .leading) {
                            
                            Text(recipe.title).bold().font(.title).foregroundColor(.white)
                        
                    }.padding().frame(width: 250, alignment: .bottomLeading).foregroundColor(.white).overlay(LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.01)]), startPoint: .center, endPoint: .bottom))
                
                VStack {
                    
                    Button(action: {
                        print("favbutton pressed")
                        dbConnection.addFavRecipeToDb(recipe: recipe)
                    }, label: {
                        
                        Image(systemName: "star.fill").resizable().frame(width: 30, height: 30).foregroundColor(.white).overlay(LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.01)]), startPoint: .center, endPoint: .bottom))
                        
                    })
                }.padding()
                }
            }.padding().frame(width: 350, height: 230, alignment: .bottomLeading).background(.black).cornerRadius(9)
        }
    }
}

struct RecipeCard_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCard(recipe: Recipe(id: 1, title: "Test", image: "https://media.sporthalsa.se/uploads/2022/01/tortillia_omelett.jpg", imageType: "", analyzedInstructions: [Instructions(steps: [Step(step: "test")])]))
    }
}
