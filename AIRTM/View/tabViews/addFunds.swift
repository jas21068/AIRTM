//
//  addFunds.swift
//  AIRTM
//
//  Created by Jaskirat Mangat on 2021-09-13.
//

import SwiftUI
import SDWebImageSwiftUI
struct addFunds: View {
    @State private var Addfund = ""
    
    @State private var Sendfund = ""
    @State private var showforex = false
    @State private var showHomeScreen = false
    @State private var email = ""
    @StateObject var settingsData = SettingsViewModel()
    @StateObject var newPostData = NewPostModel()
    var body: some View {
        NavigationView{
            VStack{
                TextField("", text: $Addfund)
                    .padding()
                    .keyboardType(.numberPad)
                    .background(Color.white.opacity(0.06))
                    .foregroundColor(.white)
                    
                    .cornerRadius(17)
                Text("Add Funds")
                    .fontWeight(.bold)
                    .font(.title)
                    .padding(.top,25)
                HStack(spacing: 15){
                    //Add fund text field
                    TextField("Enter Amount", text: $Addfund)
                        .padding()
                        .keyboardType(.numberPad)
                        .background(Color.white.opacity(0.06))
                        .cornerRadius(17)
                    //Add Fund Button
                    Button(action:{
                        let Add = Double(settingsData.userInfo.Money) + (Double(Addfund))!
                        settingsData.updateMoney(value: Add)
                        newPostData.postAdd(val: Addfund)
                        showHomeScreen.toggle()
                        hideKeyboard()
                    }, label: {
                        Text("Add")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding(.vertical)
                            .frame(width: 70)
                            .background(Color.blue)
                            .clipShape(Capsule())
                    })
                    .disabled(Addfund == "" )
                    .opacity( Addfund == "" ? 0.5 : 1)
                }
                .padding(.horizontal)
                .padding(.bottom)
                
                // OR splitter
                VStack{
                    HStack{
                        HStack{}
                            .frame(width: 135, height: 2)
                            .background(Color.gray)
                            .cornerRadius(2)
                        Text("OR")
                            .font(.body)
                            .foregroundColor(Color.gray)
                            .padding()
                        HStack{}
                            .frame(width: 135, height: 2)
                            .background(Color.gray)
                            .cornerRadius(2)
                    }
                    
                }
                .padding(.top,30)
                .padding(.bottom,30)
                
                .cornerRadius(15)
                Text("Send Funds")
                    .fontWeight(.bold)
                    .font(.title)
                
                //send email texfield
                TextField("Enter email", text: $email)
                    .padding()
                    .background(Color.white.opacity(0.06))
                    .cornerRadius(15)
                    .padding(.horizontal)
                HStack(spacing: 15){
                    //enter amount
                    TextField("Enter Amount", text: $Sendfund)
                        .padding()
                        .keyboardType(.numberPad)
                        .background(Color.white.opacity(0.06))
                        .cornerRadius(15)
                    //Send button
                    Button(action:{
                        let Send = Double(settingsData.userInfo.Money) - (Double(Sendfund))!
                        settingsData.updateMoney(value: Send)
                        newPostData.postSend(val: Sendfund)
                        showHomeScreen.toggle()
                        hideKeyboard()
                    }, label: {
                        Text("Send")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding(.vertical)
                            .frame(width: 60)
                            .background(Color.blue)
                            .clipShape(Capsule())
                        
                    })
                    .disabled(Sendfund == "" )
                    .opacity( Sendfund == "" ? 0.5 : 1)
                }
                .padding(.horizontal)
                .padding(.bottom)
                // Show Forex button
                Button(action:{
                    showforex.toggle()
                }, label: {
                    Text("Show Forex")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(width: 120)
                        .background(Color.blue)
                        .clipShape(Capsule())
                })
                
                Spacer()
            }
            .fullScreenCover(isPresented: $showHomeScreen) {
                
                ContentView()
            }
            .sheet(isPresented: $showforex) {
                
                Currency()
            }
            //Navigation bar
            .toolbar{
                
                ToolbarItem(placement: .navigationBarLeading){
                    
                    VStack{
                        
                        Image("logo")
                            .resizable()
                            .frame(width: 150, height: 50)
                            .padding(.top,25)
                        
                        HStack{
                            Text(String((Double(settingsData.userInfo.Money)*1.00.rounded())))
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .font(.system(size: 14))
                            Text(" USD")
                                .padding(.trailing,4)
                            Text(String((Double(settingsData.userInfo.Money)/1.5).rounded()))
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            Text("CAD")
                               
                        }.padding()
                        
                        HStack{}
                            .frame(width: UIScreen.main.bounds.width, height: 1)
                            .background(Color.gray)
                    }.padding(.top,50)
                }
            }
            // Nzvigation buttons
            .navigationBarItems( trailing: Button(action: {
                
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
                        
                        if settingsData.isLoading{
                            
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: Color(.blue)))
                        }
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
