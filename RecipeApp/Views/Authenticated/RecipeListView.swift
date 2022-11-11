//
//  RecipeListView.swift
//  RecipeApp
//
//  Created by Elin Pettersson on 2022-11-07.
//

import SwiftUI

struct RecipeListView: View {
    
    @EnvironmentObject var dbConnection: DatabaseConnection
    
    @State var searchRecipe = ""
    @State var searchRecipeType: String?
    @State var searchAmount: String?
    @State var recipeInList = [Recipe]()
    @State var noDataText = ""
    
    
    func fetchData(keyword: String) {
        
        let keys = RecipeAPIKey()

        guard let url = URL(string: "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/complexSearch?query=\(keyword)&type=main%20course&instructionsRequired=true&addRecipeInformation=true&number=15") else {
            print("returning at 58")
            return
        }

        var request = URLRequest(url: url, timeoutInterval: .infinity)
        guard let apiKey = keys.headers["X-RapidAPI-Key"] else {
            print("returning at line 33")
            return
        }

        print("Starting fetch")

        request.httpMethod = "GET"
        request.addValue(apiKey, forHTTPHeaderField: "X-RapidAPI-Key")
        request.addValue("spoonacular-recipe-food-nutrition-v1.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")


        let task = URLSession.shared.dataTask(with: request) { data, response, error in

            print("Fetch Data function \(String(describing: error?.localizedDescription))")
              guard let data = data else {
                print("Data is nil at line 48")
                print(String(describing: error))
                return
              }



                if let decodedResponse = try? JSONDecoder().decode(Recipes.self, from: data) {
                    self.recipeInList = decodedResponse.results
                    print("Success!!!!!!!")
                } else {
                    print("Could not decode at line 60")
                }

            }
        task.resume()
    }
                                        
            var body: some View {
            VStack {
                VStack {
                    Text("Recipes").bold().font(.title)
                }.frame(height: 70, alignment: .center).background()
                
                VStack {
                    Text("Search on any recipe").bold().font(.subheadline)
                }
                
                HStack {
                    TextField("", text: $searchRecipe).textFieldStyle(.roundedBorder)
                    
                    Button(action: {
                        
                        if searchRecipe != "" {
                            noDataText = ""
                            fetchData(keyword: searchRecipe)
                        } else {
                            noDataText = "You have to fill in the searchbar"
                        }
                        
                    }, label: {
                        Text("Search").padding().background(.brown).foregroundColor(.white).bold().cornerRadius(9)
                    })
                }.padding()
                
                
                
                ScrollView {
                    Text(noDataText).bold().font(.subheadline)
                    ForEach(recipeInList) { recipe in
                        NavigationLink(destination: RecipeView(recipe: recipe), label: {
                            RecipeCard(recipe: recipe)
                        })
                    }
                    
                    
                }.padding()
                
                VStack {
                    
                    BottomNavigationView()
                }.frame(height: 110, alignment: .bottom)
            }
            
            
        }
                                        
     }
                                        
                                        
                                        
//          struct RecipeListView_Previews: PreviewProvider {
//            static var previews: some View {
//                RecipeListView(instructionsInRecipe: Instructions(steps: <#T##[Step]#>), stepsInRecipe: <#Step#>).environmentObject(DatabaseConnection())
//            }
//        }
