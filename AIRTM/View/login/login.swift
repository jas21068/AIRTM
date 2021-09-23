
import SwiftUI

struct Login: View {
    @StateObject var loginData = LoginViewModel()
    var body: some View {
        
        
        NavigationView{
            ScrollView{
                VStack{
                    Text("Log in to Airtm")
                        .font(.title2)
                        .fontWeight(.bold)
                    Section{
                        Image("facebook")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width - 20, height: 75)
                        Image("google")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width - 20, height: 75)
                    }
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
                    HStack(spacing: 15){
                        TextField("1", text: $loginData.code)
                            .padding()
                            .frame(width: 45)
                            .background(Color.gray.opacity(0.06))
                            .cornerRadius(15)
                        
                        TextField("1234567890", text: $loginData.number)
                            .padding()
                            .background(Color.gray.opacity(0.06))
                            .cornerRadius(15)
                            .keyboardType(.numberPad)
                    }
                    .padding()
                    .padding(.top,10)
                    if loginData.isLoading{
                        ProgressView()
                            .padding()
                    }
                    else{
                        Button(action: loginData.verifyUser
                               , label: {
                                Text("Log in/Sign Up")
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                                    .padding(.vertical)
                                    .frame(width: UIScreen.main.bounds.width - 20)
                                    .background(Color.blue)
                                    .clipShape(Capsule())
                               })
                            .disabled(loginData.code == "" || loginData.number == "" ? true : false)
                            .opacity(loginData.code == "" || loginData.number == "" ? 0.5 : 1)
                    }
                    Section{
                        Text("Forgot your password?")
                            .foregroundColor(.blue)
                    }
                    .padding(.top,20)
                    
                    Spacer()
                }
                .alert(isPresented: $loginData.error, content: {
                    
                    Alert(title: Text("Error"), message: Text(loginData.errorMsg), dismissButton: .destructive(Text("Ok")))
                })
                .fullScreenCover(isPresented: $loginData.registerUser, content: {
                    
                    Register()
                })
            }
        }     .toolbar{
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
#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

