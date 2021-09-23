//
//  CryptoList.swift
//  AIRTM
//
//  Created by Jaskirat Mangat on 2021-09-19.
//

import SwiftUI
import SDWebImageSwiftUI
struct CryptoList: View {
    @State var comments: [Response1] = []
    @State private var resultCurrency = 0.00
    var body: some View {
        NavigationView{
            VStack{    
                List(comments) { comment in
                    
                    VStack(alignment: .leading) {
                        // Crypto List Design
                        HStack{
                            
                            if comment.name == "Bitcoin"{
                                Image("coin1")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 75, height: 75)
                                    .clipShape(Circle())
                            }
                            
                            else if comment.name == "Ethereum"{
                                Image("coin2")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 75, height: 75)
                                    .clipShape(Circle())
                            }
                            else if comment.name == "XRP"{
                                Image("coin3")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 75, height: 75)
                                    .clipShape(Circle())
                            }
                            else if comment.name == "Dogecoin"{
                                Image("coin4")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 75, height: 75)
                                    .clipShape(Circle())
                            }
                            
                            else if comment.name == "Litecoin"{
                                Image("coin5")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 75, height: 75)
                                    .clipShape(Circle())
                            }
                            
                            Text(comment.name)
                                .font(.title)
                                .fontWeight(.bold)
                            Spacer()
                            VStack{
                                Text("Trading At")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.red)
                                HStack{
                                    Text("$")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .foregroundColor(.green)
                                    Text(
                                        String(
                                            round((Double(comment.price)!)*100)/100
                                        )
                                    ).font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.green)
                                }
                            }
                        }
                    }
                }
            }.onAppear() {
                apiCall().getUserComments{ (comments) in
                    self.comments = comments
                }
            }
            .navigationTitle("Crypto trading prices")
        }
    }
}

struct CryptoList_Previews: PreviewProvider {
    static var previews: some View {
        CryptoList()
    }
}

