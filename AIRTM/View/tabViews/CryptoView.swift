//
//  CryptoView.swift
//  AIRTM
//
//  Created by Jaskirat Mangat on 2021-09-19.
//
import SwiftUI

struct CryptoView: View {
    // Current Index...
    @State var comments: [Response1] = []
    @State var currentIndex: Int = 0
    var body: some View {
        
        ZStack{
            
            // background Tab View...
            TabView(selection: $currentIndex){
                
                ForEach(posts.indices,id: \.self){index in
                    
                    GeometryReader{proxy in
                        
                        Image(posts[index].postImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: proxy.size.width,height: proxy.size.height)
                            .cornerRadius(1)
                    }
                    .ignoresSafeArea()
                    .offset(y: -100)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .animation(.easeInOut, value: currentIndex)

            .overlay(AnyView(LinearGradient(
                                gradient: Gradient(colors: [.clear, .black.opacity(0.2),.white.opacity(0.4),
                                                            .white,
                                                            .white,
                                                            .white,
                                ]),
                                startPoint: .top,
                                endPoint:.bottom)
                                .background(
                                
                                                    Color.black
                                                        .opacity(0.15)
                                                )
            ))
            .ignoresSafeArea()
            
            // Posts....
            SnapCarousel(spacing: getRect().height < 750 ? 15 : 20,trailingSpace: getRect().height < 750 ? 100 : 150,index: $currentIndex, items: posts) {post in
                
                CardView(post: post)
            }
            .offset(y: getRect().height / 3.5)
        }
        
    }
    
    @ViewBuilder
    func CardView(post: Post)->some View{
        
        VStack(spacing: 10){
            
            // Image...
            GeometryReader{proxy in
                
                Image(post.postImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: proxy.size.width, height: proxy.size.height)
                    .cornerRadius(25)
            }
            .padding(15)
            .background(Color.white)
            .cornerRadius(25)
            .frame(height: getRect().height / 2.5)
            .padding(.bottom,15)
            
            // Movie Data...
            Text(post.title)
                .font(.title.bold())
            
            HStack(spacing: 3){
                
                ForEach(1...5,id: \.self){index in
                    
                    Image(systemName: "star.fill")
                        .foregroundColor(index <= post.starRating ? .yellow : .gray)
                }
                
                Text("(\(post.starRating).0)")
            }
            .font(.caption)
            
            Text(post.description)
                .font(.title.bold())
                .foregroundColor(.blue)
                .multilineTextAlignment(.center)
                .padding(.top,10)
                .padding(.horizontal,10)
        }
        
    }
}

struct CryptoView_Previews: PreviewProvider {
    static var previews: some View {
        CryptoView()
            
    }
}

// Screen Bounds...
extension View{
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
}
