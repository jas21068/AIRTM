//
//  SettingsView.swift
//  AIRTM
//
//  Created by Jaskirat Mangat on 2021-09-14.
//

import SwiftUI
import SDWebImageSwiftUI

struct SettingsView: View {
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    @StateObject var settingsData = SettingsViewModel()
    @State private var showingAddCard = false
    var body: some View {
        NavigationView{
            VStack{
                Section{
                    
                    Text("Click on the details below to edit")
                        .fontWeight(.bold)
                        .font(.title3)
                        .padding(.top,30)
                }
                HStack{
                    if settingsData.userInfo.pic != ""{
                        //Image selector
                        ZStack{
                            
                            WebImage(url: URL(string: settingsData.userInfo.pic)!)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 115, height: 115)
                                .clipShape(Circle())
                            
                            if settingsData.isLoading{
                                
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: Color(.blue)))
                            }
                            
                        }
                        .padding(.top,25)
                        .padding(.trailing,10)
                        .onTapGesture {
                            settingsData.picker.toggle()
                        }
                    }
                    VStack{
                        HStack{
                            
                            Text("Name")
                        }
                        .padding(.trailing,140)
                        HStack{
                            
                            
                            Text(settingsData.userInfo.username)
                                .foregroundColor(.black)
                                .multilineTextAlignment(.leading)
                                
                                
                                .frame(width: 180, height: 30)
                                .background(Color.gray.opacity(0.06))
                                .cornerRadius(15)
                            
                            Button(action: {settingsData.updateName()}) {
                                
                                Image(systemName: "pencil.circle.fill")
                                    .font(.system(size: 24))
                                    .foregroundColor(.blue)
                            }
                            
                            
                        }
                        
                        
                        HStack{
                            
                            Text("Country")
                        }
                        .padding(.top,10)
                        .padding(.trailing,140)
                        HStack{
                            HStack(spacing: 15){
                                
                                Text(settingsData.userInfo.Country)
                                    .foregroundColor(.black)
                            }
                            
                            .frame(width: 180, height: 30)
                            .background(Color.gray.opacity(0.06))
                            .cornerRadius(15)
                            
                            
                            Button(action: {settingsData.updateDetails(field: "Address")}) {
                                
                                Image(systemName: "pencil.circle.fill")
                                    .font(.system(size: 24))
                                    .foregroundColor(.blue)
                            }
                            
                        }
                    }
                }
                
                // LogOut Button...
                
                Button(action: settingsData.logOut, label: {
                    Text("Logout")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 100)
                        .background(Color(.systemBlue).opacity(0.8))
                        .clipShape(Capsule())
                })
                .padding(.bottom,5)
                
                // Card Slider
                VStack {
                    
                    GeometryReader { geometry in
                        
                        ImageCarouselView(numberOfImages: 3) {
                            Image("card1")
                                .resizable()
                                .frame(width: 299.0, height: 170.0)
                                .scaledToFill()
                                .frame(width: geometry.size.width, height: geometry.size.height)
                                .clipped()
                            Image("card2")
                                .resizable()
                                .frame(width: 299.0, height: 170.0)
                                .scaledToFill()
                                .frame(width: geometry.size.width, height: geometry.size.height)
                                .clipped()
                            Image("card3")
                                .resizable()
                                .frame(width: 299.0, height: 170.0)
                                .scaledToFill()
                                .frame(width: geometry.size.width, height: geometry.size.height)
                                .clipped()
                        }
                    }.frame(height: 300, alignment: .center)
                    Button(action: {
                        showingAddCard.toggle()
                        print("sett")
                    }, label: {
                        Text("Add Card")
                            .font(.title3)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .frame(width: UIScreen.main.bounds.width - 250,height: 25, alignment: .center)
                            .background(Color.green)
                            .clipShape(Capsule())
                    })
                }
                Spacer()
            }
            .sheet(isPresented: $settingsData.picker) {
                
                ImagePicker(picker: $settingsData.picker, img_Data: $settingsData.img_data)
            }
            .sheet(isPresented: $showingAddCard) {
                
                AddCard(expenses: Cards())
            }
            .onChange(of: settingsData.img_data) { (newData) in
                // whenever image is selected update image in Firebase...
                settingsData.updateImage()
            }
            // Navigation Bsr
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
                               
                            Text("USD")
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
        }
        
    }
}


// slider logic

struct ImageCarouselView<Content: View>: View {
    private var numberOfImages: Int
    private var content: Content
    
    @State private var currentIndex: Int = 0
    
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    init(numberOfImages: Int, @ViewBuilder content: () -> Content) {
        self.numberOfImages = numberOfImages
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                self.content
            }
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .leading)
            .offset(x: CGFloat(self.currentIndex) * -geometry.size.width, y: 0)
            .animation(.spring())
            .onReceive(self.timer) { _ in
                
                self.currentIndex = (self.currentIndex + 1) % 3
            }
        }
        
    }
}

