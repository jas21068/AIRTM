//
//  Homebalance.swift
//  AIRTM
//
//  Created by Jaskirat Mangat on 2021-09-13.
//

import SwiftUI
import SDWebImageSwiftUI
struct Homebalance: View {
    @StateObject var settingsData = SettingsViewModel()
    @State var showLogs = false
    @State var showCrypto = false
    var body: some View {
        NavigationView{
            VStack{
                Text("My Balances")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom,20)
                    .padding(.top,35)
                
                VStack(spacing: 15){
                    
                    Image("balance")
                        .resizable()
                        .frame(width: 300, height: 200)
                    HStack{
                        Text(String((Double(settingsData.userInfo.Money)*1.00).rounded()))
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .font(.system(size: 16))
                        
                        Text("AIR USD")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .padding(.trailing,4)
                            .font(.system(size: 16))
                        
                    }
                    HStack{
                        Text(String((Double(settingsData.userInfo.Money)/1.5).rounded()))
                        
                        Text("CAD")
                            .font(.system(size: 16))
                    }.padding(.bottom,20)
                    
                }
                .background(Color.gray.opacity(0.04))
                .frame(width: UIScreen.main.bounds.width - 70)
                .cornerRadius(15)
                .border(Color.gray, width: 1)
                .padding(.bottom,10)
            //View Activity Button
                Button(action: {showLogs.toggle()
                    print("add")
                }, label: {
                    Text("View Activity")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .frame(width: UIScreen.main.bounds.width - 70,height: 40)
                        .background(Color.green)
                    
                })
                .cornerRadius(15)
                
                //Available crypto button
                Button(action: {showCrypto.toggle()
                    print("add")
                }, label: {
                    Text("Available Crypto")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .frame(width: UIScreen.main.bounds.width - 70,height: 40)
                        .background(Color(.systemBlue))
                    
                })
                .cornerRadius(15)
                .padding(.top,10)
                Spacer()
            }
            .sheet(isPresented: $showLogs) {
                
                Logs()
            }
            .sheet(isPresented: $showCrypto) {
                
                CryptoList()
            }
            //navigation  bar items
            .toolbar{
                
                ToolbarItem(placement: .navigationBarLeading){
                    
                    VStack{
                        
                        Image("logo")
                            .resizable()
                            .frame(width: 150, height: 50)
                            .padding(.top,25)
                        
                        HStack{
                            Text("Welcome")
                                .fontWeight(.bold)
                                .font(.title2)
                                .padding(.trailing,4)
                            
                            Text(settingsData.userInfo.username)
                                .fontWeight(.bold)
                                .font(.title2)
                            
                        }.padding()
                        
                        HStack{}
                            .frame(width: UIScreen.main.bounds.width, height: 1)
                            .background(Color.gray)
                    }.padding(.top,50)
                }
            }
            
            //navigation  bar button
            .navigationBarItems( trailing: Button(action: {
                showLogs.toggle()
            }) {
                if settingsData.userInfo.pic != ""{
                    
                    ZStack{
                        
                        WebImage(url: URL(string: settingsData.userInfo.pic)!)
                            .resizable()
                            .font(.system(size: 65))
                            .foregroundColor(.black)
                            .frame(width: 35, height: 35)
                            .background(Color.gray)
                            .clipShape(Circle())
                            .padding(.top,25)
                            .padding(.trailing,25)
                        
                    }
                    .padding(.top,100)
                    .padding(.trailing,10)
                    .onTapGesture {
                        
                    }
                }
                
            })
            
        }
    }
}
