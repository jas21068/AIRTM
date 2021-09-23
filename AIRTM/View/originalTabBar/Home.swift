//
//  Home.swift
//  AIRTM
//
//  Created by Jaskirat Mangat on 2021-09-13.
//
import SwiftUI
import SDWebImageSwiftUI

struct Home: View {
    @State var openSettings = false
    @State var selectedTab = "home"
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    @StateObject var settingsData = SettingsViewModel()
    
    var body: some View {
//        NavigationView{
       
            ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
                
                // Custom Tab Bar....
                
                ZStack{
                    
                    CryptoView()
                        .opacity(selectedTab == "Crypto" ? 1 : 0)
                      
                    Homebalance()
                        .opacity(selectedTab == "home" ? 1 : 0)
                    addFunds()
                        .opacity(selectedTab == "Add" ? 1 : 0)
  

                   
                        
                        
                        
                    SettingsView()
                        .opacity(selectedTab == "Settings" ? 1 : 0) 
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                CustomTabbar(selectedTab: $selectedTab)
                    .padding(.bottom,edges!.bottom == 0 ? 15 : 0)
            }
            
            .ignoresSafeArea(.all, edges: .top)

        }
        
        }  
    

