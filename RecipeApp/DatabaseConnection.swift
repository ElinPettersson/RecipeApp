//
//  DatabaseConnection.swift
//  RecipeApp
//
//  Created by Elin Pettersson on 2022-11-07.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import SwiftUI

class DatabaseConnection: ObservableObject {
    
    private var db = Firestore.firestore()
    
    @Published var favRecipes = [Recipe]()
    @Published var userLoggedIn = false
    @Published var currentUser: User?
    @Published var userDocument: UserDocument?
    
    
    private var recipeListener: ListenerRegistration?
    
    private var userCollection = "userDocuments"
    var recipeInList = [Recipe]()
    
    init() {
        
        Auth.auth().addStateDidChangeListener {
            auth, user in
            
            if let user = user {
                
                self.userLoggedIn = true
                self.currentUser = user
                self.startListeningToRecipeDb()
                
            } else {
                self.userLoggedIn = false
                self.currentUser = nil
                self.stopListeningToRecipeDb()
            }
        }
    }
    
    
   
   
    
    func SignOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error signing out!")
        }
    }
    
    func LoginUser(email: String, password: String) {
        
        Auth.auth().signIn(withEmail: email, password: password) {
            authDataResult, error in
            
            if let error = error {
                print("Something went wrong, \(error.localizedDescription)")
                return
            }
        }
    }
    
    func RegisterUser(email: String, password: String) {
        
        Auth.auth().createUser(withEmail: email, password: password) {
            authDataResult, error in
            
            if let error = error {
                print("Something went wrong, \(error.localizedDescription)")
                return
            }
            
            if let authDataResult = authDataResult {
                
                
                let newUserDocument = UserDocument(id: authDataResult.user.uid, favRecipes: [])
                
                do {
                    
                    try self.db.collection(self.userCollection).document(authDataResult.user.uid).setData(from: newUserDocument)
                    
                } catch {
                    
                    print("error")
                    
                }
            }
        }
    }
    
    
    func addFavRecipeToDb(recipe: Recipe) {
        
        if let currentUser = currentUser {
        
            do {
                try db.collection(userCollection).document(currentUser.uid).updateData(["favRecipes": FieldValue.arrayUnion([Firestore.Encoder().encode(recipe)])])
                
            } catch {
                print("Couldnt add fav recipe to db")
            }
            
        }
    }
    
    func stopListeningToRecipeDb() {
        if let recipeListener = recipeListener {
            recipeListener.remove()
        }
    }
    
    func startListeningToRecipeDb() {
        
        if let currentUser = currentUser {
            
            recipeListener = self.db.collection(userCollection).document(currentUser.uid).addSnapshotListener {
                snapshot, error in
                
                if let error = error {
                    print("Error occurred at 129 \(error)")
                    return
                }
                
                guard let snapshot = snapshot else {
                    return
                }
                
                
                self.favRecipes = []
                
 
                let result = Result {
                    try snapshot.data(as: UserDocument.self)
                }

                    switch result {
                    case .success(let userData):
                        for recipe in userData.favRecipes {
                            self.favRecipes.append(recipe)
                        }
                        break
                    case .failure(let error):
                        print("Something went wrong retrieving data: \(error)")
                        break

                }
            }
        }
    }
}



