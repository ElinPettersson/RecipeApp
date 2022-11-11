//
//  RecipeView.swift
//  RecipeApp
//
//  Created by Elin Pettersson on 2022-11-02.
//

import SwiftUI
import Foundation

struct RecipeView: View {
    
    @EnvironmentObject var dbConnection: DatabaseConnection
    
    var recipe: Recipe
    
    var body: some View {
        
        VStack {
            
            Spacer()
                
                ZStack {
                    
                    AsyncImage(url: URL(string: recipe.image), content: {
                        image in
                        
                        image.resizable().opacity(0.8)
                        
                    }, placeholder: {
                        Text("Loading").foregroundColor(.white)
                    }).overlay(LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.01), Color.black]), startPoint: .center, endPoint: .bottom))
                    
                    Button(action: {
                        print("favbutton pressed")
                        dbConnection.addFavRecipeToDb(recipe: recipe)
                    }, label: {
                        
                        Image(systemName: "star.fill").resizable().frame(width: 30, height: 30, alignment: .bottomTrailing).foregroundColor(.white).overlay(LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.01)]), startPoint: .center, endPoint: .bottom))
                        
                    }).frame(alignment: .bottomTrailing)
                    
                }.frame(width: 350, height: 250).background(.black).cornerRadius(9)
           
            VStack {
                Text(recipe.title).font(.largeTitle).bold()
            }
            
            ScrollView {
                VStack(alignment: .leading) {
                    

                    
                    
                    
//                    ForEach(instructionInRecipe.steps, id: \.self) { steps in
//                        Text(stepsInRecipe.step)
//                    }
                    
                    
                    ForEach(recipe.analyzedInstructions, id: \.self) { instruction in
                        ForEach(instruction.steps, id: \.self) { step in
                            Text(step.step)
                            
                        }
                    }

                    
                    
                    
                    Spacer()
                }.foregroundColor(.black).padding()
            }
            
            }
        }
    }


//struct RecipeView_Previews: PreviewProvider {
//    static var previews: some View {
//        ZStack {
//            RecipeView(, recipe: Recipe(id: <#T##Int#>, title: <#T##String#>, image: <#T##String#>, imageType: <#T##String#>, analyzedInstructions: <#T##[Instructions]#>))
//        }
//    }
//}
