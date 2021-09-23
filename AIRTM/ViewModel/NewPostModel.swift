//
//  PostViewModel.swift
//  AIRTM
//
//  Created by Jaskirat Mangat on 2021-09-15.
//

import SwiftUI
import Firebase

class NewPostModel : ObservableObject{
    
    @Published var postTxtAdd = ""
    @Published var postTxtSend = ""
    @Published var postAdd = true
    @Published var postSend = false
    // Image Picker...
    @Published var picker = false
    @Published var img_Data = Data(count: 0)
    
    // disabling all controls while posting...
    @Published var isPosting = false
    
    let uid = Auth.auth().currentUser!.uid

    func postAdd(val:String){
        
        ref.collection("Posts").document().setData([
        
            "title": val,
            "status":self.postAdd,
         
            "ref": ref.collection("Users").document(self.uid),
            "time": Date()
            
        ]) { (err) in
            
            if err != nil{
                self.isPosting = false
                return
            }
        }
    }
    func postSend(val:String){
        
        ref.collection("Posts").document().setData([
        
            "title": val,
            "status":self.postSend,
         
            "ref": ref.collection("Users").document(self.uid),
            "time": Date()
            
        ]) { (err) in
            
            if err != nil{
                self.isPosting = false
                return
            }
        }
    }

}
