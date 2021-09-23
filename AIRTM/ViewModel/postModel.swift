//
//  postModel.swift
//  AIRTM
//
//  Created by Jaskirat Mangat on 2021-09-15.
//

import Foundation

import SwiftUI
import Firebase

class PostViewModel : ObservableObject{
    
    @Published var posts : [PostModel] = []
    @Published var noPosts = false
    @Published var newPost = false
   
    
    
    init() {
        
        getAllPosts()
    }
    
    func getAllPosts(){
        
        ref.collection("Posts").addSnapshotListener { (snap, err) in
            guard let docs = snap else{
                self.noPosts = true
                return
                
            }
            
            if docs.documentChanges.isEmpty{
                
                self.noPosts = true
                return
            }
            
            docs.documentChanges.forEach { (doc) in
                
                // Checking If Doc Added...
                if doc.type == .added{
                    
                    // Retreving And Appending...
                    
                    let title = doc.document.data()["title"] as! String
                    let time = doc.document.data()["time"] as! Timestamp
                    let userRef = doc.document.data()["ref"] as! DocumentReference
                    let update = doc.document.data()["status"] as! Bool
                    // getting user Data...
                    
                    fetchUser(uid: userRef.documentID) { (user) in
                        
                        self.posts.append(PostModel(id: doc.document.documentID, title: title, time: time.dateValue(), user: user, status: update))
                        self.posts.sort { (p1, p2) -> Bool in
                            return p1.time > p2.time
                        }
                    }
                }
                
                // removing post when deleted...
                
                if doc.type == .removed{
                    
                    let id = doc.document.documentID
                    
                    self.posts.removeAll { (post) -> Bool in
                        return post.id == id
                    }
                }
                
                if doc.type == .modified{
                    print("Updated...")
                    // Updating Doc...
                    
                    let id = doc.document.documentID
                    let title = doc.document.data()["title"] as! String
                    
                    let index = self.posts.firstIndex { (post) -> Bool in
                        return post.id == id
                    } ?? -1
                    
                    // safe Check...
                    if index != -1{
                        
                        self.posts[index].title = title
                       
                    }
                }
            }
        }
    }
    
    // deleting Posts...
    
    func deletePost(id: String){
        
        ref.collection("Posts").document(id).delete { (err) in
            if err != nil{
                print(err!.localizedDescription)
                return
            }
        }
    }
    
 
 
}

