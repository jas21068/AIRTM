//
//  personaRow.swift
//  AIRTM
//
//  Created by Jaskirat Mangat on 2021-09-15.
//

import SwiftUI
import Firebase

struct personalRow: View {
    var post : PostModel
    @ObservedObject var postData : PostViewModel
    let uid = Auth.auth().currentUser!.uid
    
    var body: some View {
        
        VStack(spacing: 15){
            if post.user.id == uid{
                
                HStack{
                    Spacer()
                    HStack{
                        Text("$")
                            .fontWeight(.bold)
                            .font(.title)
                            .foregroundColor(.blue)
                        Text(post.title)
                            .fontWeight(.bold)
                            .font(.title)
                            .foregroundColor(.blue)
                    }
                    if post.status == true{
                        HStack{
                            VStack{
                                Text("  were added on")
                                    .font(.title2)
                                HStack{
                                    Text(post.time,style: .date)
                                        .font(.caption)
                                    Text(
                                        "at")
                                        .font(.caption)
                                    Text(post.time,style: .time)
                                        .font(.caption)
                                }
                            }
                            Spacer()
                            Image(systemName: "arrowshape.turn.up.right.fill")
                                .renderingMode(.template)
                                .resizable()
                                .frame(width: 38, height: 28)
                                .foregroundColor(.green)
                                .padding(.trailing,20)
                            
                        }
                    }
                    
                    else if post.status == false{
                        HStack{
                            VStack{
                                Text("  were sent on")
                                    
                                    .font(.title2)
                                HStack{
                                    Text(post.time,style: .date)
                                        .font(.caption)
                                    Text(
                                        "at")
                                        .font(.caption)
                                    Text(post.time,style: .time)
                                        .font(.caption)
                                }
                            }
                            Spacer()
                            Image(systemName: "arrowshape.turn.up.left.fill")
                                .renderingMode(.template)
                                .resizable()
                                .frame(width: 38, height: 28)
                                .foregroundColor(.red)
                                .padding(.trailing,20)
                            
                        }
                    }
                }
            }
        } .padding(.bottom,10)
        .background(Color.gray.opacity(0.3))
        .cornerRadius(15)
        .frame(width: UIScreen.main.bounds.width - 60, height: 40)
        
    }
}


