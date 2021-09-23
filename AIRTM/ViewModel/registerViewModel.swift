
//
//  RegisterViewModel.swift
//  Dhillon
//
//  Created by Jaskirat Mangat on 2021-08-30.
//

import SwiftUI
import Firebase

class RegisterViewModel : ObservableObject{
    
    @Published var name = ""
    @Published var country = ""
    @Published var  money = 0
    @Published var picker = false
    @Published var image_Data = Data(count: 0)
    
    
    let ref = Firestore.firestore()
    // Loading View...
    @Published var isLoading = false
    @AppStorage("current_status") var status = false
    
    func register(){
        
        isLoading = true
        // setting User Data To Firestore....
        
        let uid = Auth.auth().currentUser!.uid
        
        UploadImage(imageData: image_Data, path: "profile_Photos") { (url) in
            
            self.ref.collection("Users").document(uid).setData([
            
                "uid": uid,
                "imageurl": url,
                "username": self.name,
                "Country": self.country,
                "Money": self.money,
                "dateCreated": Date()
                
            ]) { (err) in
             
                if err != nil{
                    self.isLoading = false
                    return
                }
                self.isLoading = false
                // success means settings status as true...
                self.status = true
            }
        }
        

    }
}
