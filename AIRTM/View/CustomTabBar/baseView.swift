//
//  baseView.swift
//  AIRTM
//
//  Created by Jaskirat Mangat on 2021-09-19.
//

import Foundation
import SwiftUI

struct BaseView: View {
    @State var currentTab = "house.fill"
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    // Hiding native tab bar...
    init(){
        UITabBar.appearance().isHidden = true
    }
    
    // Curve Axis Value....
    @State var curveAxis: CGFloat = 75
    
    var body: some View {
        NavigationView{
        VStack(spacing: 0){
            
            // Tab View...
            TabView(selection: $currentTab){
                
                // Tab Views.....
                
                Homebalance()
                    .tag("house.fill")
               addFunds()
                    .tag("icloud.and.arrow.up")
                
                CryptoView()
                    .tag("briefcase")
                
                SettingsView()
                    .tag("person.fill")
            }
            .clipShape(
            
                CustomTabCurve(curveAxis: curveAxis)
            )
            .padding(.bottom,-85)
            
            HStack(spacing: 0){
                
                // Tab BUttons...
                TabButtons()
            }
            .frame(height: 80)
            .padding(.horizontal,35)
            .padding(.bottom,getSafeArea().bottom == 0 ? 10 : 0)
        }
        .background(Color(.systemBlue))
        .ignoresSafeArea(.all)
        }
    }
    
    
    @ViewBuilder
    func TabButtons()->some View{
        
        ForEach(["house.fill","icloud.and.arrow.up","briefcase","person.fill"],id: \.self){image in
            
            GeometryReader{proxy in
                
                // Since we need current postion for curve...
                
                Button {
                    withAnimation{
                        currentTab = image
                        // updating curve axis...
                        curveAxis = proxy.frame(in: .global).midX
                    }
                } label: {
                    
                    Image(systemName: image)
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 45,height: 45)
                        .background(
                        
                            Circle()
                                .fill(Color(.systemBlue))
                        )
                        .offset(y: currentTab == image ? -30 : 0)
                }
                .frame(maxWidth: .infinity,alignment: .center)
                // intial update...
                .onAppear {

                    if curveAxis == 0 && image == "house.fill"{
                        curveAxis = proxy.frame(in: .global).midX
                    }
                }

            }
            .frame(height: 85)
        }
    }
}

struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}
