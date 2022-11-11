//
//  Recipe.swift
//  RecipeApp
//
//  Created by Elin Pettersson on 2022-11-07.
//

import Foundation
import FirebaseFirestoreSwift

struct Recipes: Codable, Hashable {
    
    var results: [Recipe]
}

struct UserDocument: Codable, Identifiable {

        @DocumentID var id: String?
        var favRecipes: [Recipe]
}

struct Recipe: Codable, Identifiable, Hashable {
    
    var id: Int
    var title: String
    var image: String
    var imageType: String
//    var summary: String
    var analyzedInstructions: [Instructions]

}

struct Instructions: Codable, Hashable {
    

//    var name: String
    var steps: [Step]
}


struct Step: Codable, Hashable {
    
//    var number: Int
    var step: String
//    var ingredients: [Ent]
//    var equipment: [Ent]
//    var length: Length?
}

//struct Ent: Codable {
//    var id: Int
//    var name : String
//    var localizedName: String
//    var image: String
//    var temperature: Length?
//}
//
//
//struct Length: Codable {
//    var number: Int
//    var unit: String
//}

