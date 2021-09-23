
import SwiftUI

struct CustomTabbar: View {
    @Binding var selectedTab : String
    var body: some View {
        
        HStack(spacing: 15){
            
          
            TabButton(title: "home", image: "homekit", selectedTab: $selectedTab)
            
            TabButton(title: "Add", image: "icloud.and.arrow.up", selectedTab: $selectedTab)
            TabButton(title: "Crypto", image: "briefcase", selectedTab: $selectedTab)
            TabButton(title: "Settings", image: "gearshape", selectedTab: $selectedTab)
           
           
         
         
          
            
        }
        .padding(.horizontal)
        .background(Color.gray.opacity(0.3))
        .clipShape(Capsule())
        
    }
}

struct TabButton : View {
    
    var title : String
    var image: String
    @Binding var selectedTab : String
    
    var body: some View{
        
        Button(action: {selectedTab = title}) {
            
            VStack(spacing: 5){
                
                Image(systemName: image)
                    .renderingMode(.template)
                
                Text(title)
                    .font(.caption)
                    .fontWeight(.bold)
            }
            .foregroundColor(selectedTab == title ? Color.blue : .white)
            .background(Color.gray.opacity(0.0))
            .padding(.horizontal)
            .padding(.vertical,10)
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}
