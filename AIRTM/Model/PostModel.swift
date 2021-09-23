//
//  PostModel.swift
//  AIRTM
//
//  Created by Jaskirat Mangat on 2021-09-15.
//

import Foundation

import SwiftUI

struct PostModel : Identifiable {
    
    var id: String
    var title : String
    
    var time : Date
    var user: UserModel
    var status:Bool
}
