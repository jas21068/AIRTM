//
//  ContentView.swift
//  AIRTM
//
//  Created by Jaskirat Mangat on 2021-09-13.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("current_status") var status = false
    var body: some View {
        NavigationView{
            
            VStack{
                
                if status{BaseView()}
                else{Login()}
            }
           
        } .navigationTitle("")
        .navigationBarHidden(true)
        .statusBar(hidden: true)
}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
