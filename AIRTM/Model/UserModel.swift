//
//  UserModel.swift
//  AIRTM
//
//  Created by Jaskirat Mangat on 2021-09-13.
//

import Foundation

import SwiftUI



struct UserModel : Identifiable{

    
   
    
    var username : String
    var pic : String
    var Country: String
    var id : String
    var Money:Int

    
    
}


struct RateResult: Codable {
    let rates: [String: Double]
    let base, date: String
}

struct rates: Codable {
    var USD : Double
    var CAD : Double
    var PLN : Double
    var MXN : Double
    var AUD : Double
}
