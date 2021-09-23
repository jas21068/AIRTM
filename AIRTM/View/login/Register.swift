
import SwiftUI

import SwiftUI

struct Register: View {
    
    @StateObject var registerData = RegisterViewModel()
    @State private var type = "Canada"
    static let types = ["Canada", "USA", "Mexico", "Brazil", "Argentina"]
    var body: some View {
        NavigationView{
            VStack{
                
                Text("Register to Airtm")
                    .font(.title2)
                    .fontWeight(.bold)
                
                ZStack{
                    
                    if registerData.image_Data.count == 0{
                        
                        Image(systemName: "person")
                            .font(.system(size: 65))
                            .foregroundColor(.black)
                            .frame(width: 115, height: 115)
                            .background(Color.gray)
                            .clipShape(Circle())
                    }
                    else{
                        
                        Image(uiImage: UIImage(data: registerData.image_Data)!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 115, height: 115)
                            .clipShape(Circle())
                    }
                    
                }
                .padding(.top)
                .onTapGesture(perform: {
                    registerData.picker.toggle()
                })
                
                HStack{
                    
                    TextField("Name", text: $registerData.name)
                        .padding()
                        .multilineTextAlignment(.center)
                        .background(Color.white.opacity(0.06))
                        .cornerRadius(15)
                }
                .padding()
                .multilineTextAlignment(.center)
                
                
                HStack{
                    
                    Picker("Choose Country", selection: $registerData.country) {
                        ForEach(Self.types, id: \.self) {
                            Text($0)
                                .font(.system(size: 14))
                        }
                    }
                }
                
                if registerData.isLoading{
                    
                    ProgressView()
                        .padding()
                }
                else{
                    
                    Button(action: registerData.register, label: {
                        Text("Register")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 20)
                            .background(Color.blue)
                            .clipShape(Capsule())
                    })
                    .disabled(registerData.image_Data.count == 0 || registerData.name == "" || registerData.country == "" ? true : false)
                    .opacity(registerData.image_Data.count == 0 || registerData.name == "" || registerData.country == "" ? 0.5 : 1)
                }
            }
            .sheet(isPresented: $registerData.picker, content: {
                ImagePicker(picker: $registerData.picker, img_Data: $registerData.image_Data)
            })
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    VStack{
                        Image("logo")
                            .resizable()
                            .frame(width: 180, height: 70)
                            .padding(.top,25)
                        
                        HStack{}
                            .frame(width: UIScreen.main.bounds.width, height: 1)
                            .background(Color.gray)       
                    }
                    
                }
            }
        }
    }
}

