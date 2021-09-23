//
//  CryptoViewModel.swift
//  AIRTM
//
//  Created by Jaskirat Mangat on 2021-09-19.
//

import Foundation
import Foundation

class apiCall {
    func getUserComments(completion:@escaping ([Response1]) -> ()) {
        guard let url = URL(string: "https://api.nomics.com/v1/currencies/ticker?key=0f04adea9f3bef8f857be3ac48109e98af36e564&ids=BTC,ETH,DOGE,LTC,XRP&interval=1d,30d&convert=USD&per-page=100&page=1") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let comments = try! JSONDecoder().decode([Response1].self, from: data!)
            print(comments)
            
            DispatchQueue.main.async {
                completion(comments)
            }
        }
        .resume()
    }
}
