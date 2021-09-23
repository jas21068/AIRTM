//
//  fetchUser.swift
//  AIRTM
//
//  Created by Jaskirat Mangat on 2021-09-14.
//

import SwiftUI
import Firebase

// Global Refernce

let ref = Firestore.firestore()

func fetchUser(uid: String,completion: @escaping (UserModel) -> ()){
    
    ref.collection("Users").document(uid).getDocument { (doc, err) in
        guard let user = doc else{return}
        
        let username = user.data()?["username"] as! String
        let pic = user.data()?["imageurl"] as! String
        let Country = user.data()?["Country"] as! String
        let Money = user.data()?["Money"] as! Int
        let uid = user.documentID
        
        DispatchQueue.main.async {
            completion(UserModel(username: username, pic: pic, Country: Country, id: uid, Money: Money))
        }
    }
}
