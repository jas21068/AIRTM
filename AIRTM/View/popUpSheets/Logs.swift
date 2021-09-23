//
//  Logs.swift
//  AIRTM
//
//  Created by Jaskirat Mangat on 2021-09-15.
//

import SwiftUI

struct Logs: View {
    @StateObject var postData = PostViewModel()
    var body: some View {
        NavigationView{
        ScrollView{
            VStack(spacing: 15){                
                ForEach(postData.posts){post in
                    
                    personalRow(post: post,postData: postData)
                }
            }
            .padding()
            .padding(.bottom,55)
        }
        .navigationBarTitle("RECENT ACTIVITIES")
        }
    }
}


