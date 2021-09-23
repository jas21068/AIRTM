//
//  Cards.swift
//  AIRTM
//
//  Created by Jaskirat Mangat on 2021-09-14.
//

import Foundation
struct CardItem: Identifiable , Codable{
    var id = UUID()
    let name: String
    let type: String
    let amount: Int
}
class Cards: ObservableObject {
    @Published var items = [CardItem](){
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([CardItem].self, from: items) {
                self.items = decoded
                return
            }
        }

        self.items = []
    }
}
