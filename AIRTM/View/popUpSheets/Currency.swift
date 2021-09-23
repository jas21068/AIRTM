//
//  Currency.swift
//  AIRTM
//
//  Created by Jaskirat Mangat on 2021-09-14.
//

import SwiftUI

struct Currency: View {
    @State private var AddCurrency = ""
    
    @State private var resultCurrency = 0.00
    @State private var results = RateResult(rates: [:], base: "", date: "")
    var body: some View {
        VStack{
            Text("LIVE CURRENCY EXCHANGE")
                .foregroundColor(.green)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top,60)
            HStack{
                TextField("Enter Amount", text: $AddCurrency)
                    .padding()
                    .multilineTextAlignment(.center)
                    .background(Color.white.opacity(0.06))
                    .cornerRadius(15)
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad)
                
                Button(action:{
                    resultCurrency = Double(AddCurrency)!
                    hideKeyboard()
                }, label: {
                    Text("Check")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(width: 60)
                        .background(Color.blue)
                        .clipShape(Capsule())
                        .padding(.trailing,20)
                })
                .disabled(AddCurrency == "" )
                .opacity( AddCurrency == "" ? 0.5 : 1)
                
            }
            
            
            HStack{
                
                HStack{
                    Spacer()
                    VStack{
                        Text("CAD")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                        Text(String(resultCurrency*1.5))
                            .foregroundColor(.green)
                            .font(.title3)
                    }
                    Spacer()
                }.background(Color.gray.opacity(0.4))
                .frame(width: UIScreen.main.bounds.width/3)
                .cornerRadius(15)
                .padding(.trailing,40)
                HStack{
                    Spacer()
                    VStack{
                        Text("MXN")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                        Text(String(resultCurrency*20.0))
                            .foregroundColor(.green)
                            .font(.title3)
                    }
                    Spacer()
                }.background(Color.gray.opacity(0.4))
                .frame(width: UIScreen.main.bounds.width/3)
                .cornerRadius(15)
                
            }
            .padding(.bottom,20)
            HStack{
                
                HStack{
                    Spacer()
                    VStack{
                        Text("IND")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                        Text(String(resultCurrency*74.0))
                            .foregroundColor(.green)
                            .font(.title3)
                    }
                    Spacer()
                }.background(Color.gray.opacity(0.4))
                .frame(width: UIScreen.main.bounds.width/3)
                .cornerRadius(15)
                .padding(.trailing,40)
                HStack{
                    Spacer()
                    VStack{
                        Text("GBP")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                        Text(String(
                            round((resultCurrency*0.70)*100)/100
                        ))
                        .foregroundColor(.green)
                        .font(.title3)
                    }
                    Spacer()
                }.background(Color.gray.opacity(0.4))
                .frame(width: UIScreen.main.bounds.width/3)
                .cornerRadius(15)
                
            }
            .padding(.bottom,20)
            HStack{
                
                HStack{
                    Spacer()
                    VStack{
                        Text("AUD")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                        Text(String( round((resultCurrency*1.35)*100)/100))
                            .foregroundColor(.green)
                            .font(.title3)
                    }
                    Spacer()
                }.background(Color.gray.opacity(0.4))
                .frame(width: UIScreen.main.bounds.width/3)
                .cornerRadius(15)
                .padding(.trailing,40)
                HStack{
                    Spacer()
                    VStack{
                        Text("JPN")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                        Text(String(resultCurrency*110.0))
                            .foregroundColor(.green)
                            .font(.title3)
                    }
                    Spacer()
                }.background(Color.gray.opacity(0.4))
                .frame(width: UIScreen.main.bounds.width/3)
                .cornerRadius(15)
                
            }
            .padding(.bottom,20)
            HStack{
                
                HStack{
                    Spacer()
                    VStack{
                        Text("YUAN")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                        Text(String( round((resultCurrency*6.40)*100)/100))
                            .foregroundColor(.green)
                            .font(.title3)
                    }
                    Spacer()
                }.background(Color.gray.opacity(0.4))
                .frame(width: UIScreen.main.bounds.width/3)
                .cornerRadius(15)
                .padding(.trailing,40)
                HStack{
                    Spacer()
                    VStack{
                        Text("RUB")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                        Text(String(resultCurrency*72.0))
                            .foregroundColor(.green)
                            .font(.title3)
                    }
                    Spacer()
                }.background(Color.gray.opacity(0.4))
                .frame(width: UIScreen.main.bounds.width/3)
                .cornerRadius(15)
                
            }
            Spacer()
        }.onAppear(perform: loadData)
    }
    
   // API Call
    func loadData() {
        guard let url = URL(string: "http://api.exchangeratesapi.io/v1/latest?access_key=109e827c6495436be2d0e932c579a68a&symbols=USD,AUD,CAD,PLN,MXN&format=1") else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(RateResult.self, from: data) {
                    // we have good data – go back to the main thread
                    
                    DispatchQueue.main.async {
                        // update our UI
                        self.results = decodedResponse
                        
                    }
                    // everything is good, so we can exit
                    return
                }
            }
            // if we're still here it means there was a problem
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}


