//
//  cryptoModel.swift
//  AIRTM
//
//  Created by Jaskirat Mangat on 2021-09-19.
//

import Foundation

import SwiftUI

// Post Model and Sample Data...
struct Post: Identifiable{
    var id = UUID().uuidString
    var postImage: String
    var title: String
    var description: String
    var starRating: Int
}

var posts = [

    Post(postImage: "coin1",title: "Bitcoin",description: "$47710.63",starRating: 4),
    
    Post(postImage: "coin2",title: "Ethereum",description: "$3355.00",starRating: 5),
    
    Post(postImage: "coin3",title: "Dogecoin",description: "$0.23",starRating: 4),
    
    Post(postImage: "coin4",title: "LiteCoin",description: "$176.03",starRating: 5),
    
    Post(postImage: "coin5",title: "Ripple",description: "$1.06",starRating: 3),
    
]
