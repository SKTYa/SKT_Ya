//
//  HomeViewLearn.swift
//  Lingua
//
//  Created by Jin Sang woo on 2023/08/30.
//

import SwiftUI

struct HomeViewLearn: View {
    var body: some View {
        
            
            VStack(){
                HStack(spacing : 16){
                    
                    NavigationLink(destination: SpeakView()) {
                        
                        
                        RoundedRectangle(cornerRadius: 24)
                            .frame(width:175, height:224)
                            .foregroundStyle(LinearGradient(
                                colors: [Color("Primary"), Color("Secondary")],
                                startPoint: .top, endPoint: .bottom))
                            .overlay(){
                                ZStack(){
                                    VStack(alignment: .leading){
                                        
                                        Image(systemName: "arrow.up.right")
                                            .font(.system(size: 24).weight(.bold))
                                            .foregroundColor(Color("BG"))
                                            .padding(.leading, 125)
                                            .padding(.trailing, 16)
                                            .padding(.top, 19)
                                        
                                        Spacer()
                                        
                                        
                                        
                                        Text("학습하기")
                                            .font(.system(size: 22).weight(.bold))
                                            .foregroundColor(Color("BG"))
                                            .padding(.leading, 22)
                                            .padding(.bottom, 16)
                                        
                                        
                                    }
                                    
                                    
                                    Image("inv_book")
                                        .resizable()
                                        .frame(width:79, height:99)
                                        .opacity(0.4)
                                }
                            }
                    }
                    
                    VStack(spacing : 16){
                        RoundedRectangle(cornerRadius: 24)
                            .frame(width:167, height:104)
                            .foregroundColor(Color("list_fill"))
                            .overlay(){
                                VStack(alignment: .leading){
                                    
                                    Image(systemName: "arrow.up.right")
                                        .font(.system(size: 24).weight(.bold))
                                        .foregroundColor(Color("wht"))
                                        .opacity(0.75)
                                        .padding(.leading, 125)
                                        .padding(.trailing, 16)
                                        .padding(.top, 19)
                                    
                                    Spacer()
                                    
                                    Text("AI 분석")
                                        .font(.system(size: 22).weight(.bold))
                                        .foregroundColor(Color("wht"))
                                        .padding(.leading, 22)
                                        .padding(.bottom, 16)
                                    
                                    
                                }
                            }
                        
                        RoundedRectangle(cornerRadius: 24)
                            .frame(width:167, height:104)
                            .foregroundColor(Color("list_fill"))
                            .overlay(){
                                VStack(alignment: .leading){
                                    
                                    Image(systemName: "arrow.up.right")
                                        .font(.system(size: 24).weight(.bold))
                                        .foregroundColor(Color("wht"))
                                        .opacity(0.75)
                                        .padding(.leading, 125)
                                        .padding(.trailing, 16)
                                        .padding(.top, 19)
                                    
                                    Spacer()
                                    
                                    Text("북마크")
                                        .font(.system(size: 22).weight(.bold))
                                        .foregroundColor(Color("wht"))
                                        .padding(.leading, 22)
                                        .padding(.bottom, 16)
                                    
                                    
                                }
                            }
                        
                        
                    }
                }
                
                Spacer().frame(height:36)
                
            }
        
    }
}

struct HomeViewLearn_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewLearn()
    }
}
