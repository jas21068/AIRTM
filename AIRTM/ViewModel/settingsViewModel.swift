//
//  settingsViewModel.swift
//  AIRTM
//
//  Created by Jaskirat Mangat on 2021-09-14.
//

import Foundation
import SwiftUI

import Firebase

class SettingsViewModel : ObservableObject{
    
    @Published var userInfo = UserModel(username: "", pic: "", Country: "", id: "", Money: 0)
    @AppStorage("current_status") var status = false
    
    // Image Picker For Updating Image...
    @Published var picker = false
    @Published var img_data = Data(count: 0)
    
    // Loading View..
    @Published var isLoading = false
    
    let ref = Firestore.firestore()
    let uid = Auth.auth().currentUser!.uid
    
    init() {
        
        fetchUser(uid: uid) { (user) in
            self.userInfo = user
        }
    }
    
    
    func logOut(){
        
        // logging out..
        
        try! Auth.auth().signOut()
        status = false
    }
    
    func updateImage(){
        
        isLoading = true
        
        UploadImage(imageData: img_data, path: "profile_Photos") { (url) in
            
            self.ref.collection("Users").document(self.uid).updateData([
            
                "imageurl": url,
            ]) { (err) in
                if err != nil{return}
                
                // Updating View..
                self.isLoading = false
                fetchUser(uid: self.uid) { (user) in
                    self.userInfo = user
                }
            }
        }
    }
    
    func updateDetails(field : String){
        
        alertView(msg: "Update \(field)") { (txt) in
            
            if txt != ""{
                
                self.updateBio(id: field == "Name" ? "username" : "Country", value: txt)
            }
        }
    }
    
    func updateName(){
        
        alertView(msg: "Update Name") { (txt) in
            
            if txt != ""{
                
                self.updateBio(id: "username", value: txt)
            }
        }
    }
    
    func updateBio(id: String,value: String){
        
        ref.collection("Users").document(uid).updateData([
        
            id: value,
        ]) { (err) in
            
            if err != nil{return}
            
            // refreshing View...
            
            fetchUser(uid: self.uid) { (user) in
                self.userInfo = user
            }
        }
    }
    
    func updateMoney(value:Double){

        ref.collection("Users").document(uid).updateData([
            "Money": value
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
//        getAllPosts()
    }
    
}

