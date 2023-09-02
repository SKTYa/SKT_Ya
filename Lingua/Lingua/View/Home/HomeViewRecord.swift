//
//  HomeViewRecord.swift
//  Lingua
//
//  Created by Jin Sang woo on 2023/08/30.
//

import SwiftUI

struct HomeViewRecord: View {
    var body: some View {
        
        
        HStack(){
            Text("학습기록")
                .font(.system(size: 20).weight(.bold))
                .foregroundColor(Color("wht"))
            
            Spacer()
            
            Text("전체보기 \(Image(systemName: "chevron.right"))")
                .font(.system(size: 14).weight(.bold))
                .opacity(0.5)
                .foregroundColor(Color("wht"))
            
            
        }
        .padding(.leading, 16)
        .padding(.trailing, 8)
        
        VStack(){
            RoundedRectangle(cornerRadius: 24)
                .frame(width:.infinity, height:68)
                .foregroundColor(Color("list_fill"))
                .overlay(){
                    HStack(spacing : 16){
                        Circle()
                            .frame(width:36, height:36)
                            .foregroundColor(Color("Secondary"))
                        Text("2023.08.29")
                            .font(.system(size: 14).weight(.bold))
                            .foregroundColor(Color("wht"))
                            .opacity(0.75)
                        Text("2단계 문장 말하기...")
                            .font(.system(size: 14).weight(.bold))
                            .foregroundColor(Color("wht"))
                            .opacity(0.75)
                        Image(systemName: "arrow.right")
                            .font(.system(size: 20))
                            .foregroundColor(Color("wht"))
                            .opacity(0.75)
                        
                        
                        
                    }
                    
                }
                .foregroundColor(Color("list_fill"))
            
            RoundedRectangle(cornerRadius: 24)
                .frame(width:.infinity, height:68)
                .foregroundColor(Color("list_fill"))
                .overlay(){
                    HStack(spacing : 16){
                        Circle()
                            .frame(width:36, height:36)
                            .foregroundColor(Color("Secondary"))
                        Text("2023.08.24")
                            .font(.system(size: 14).weight(.bold))
                            .foregroundColor(Color("wht"))
                            .opacity(0.75)
                        Text("2단계 문장 말하기...")
                            .font(.system(size: 14).weight(.bold))
                            .foregroundColor(Color("wht"))
                            .opacity(0.75)
                        Image(systemName: "arrow.right")
                            .font(.system(size: 20))
                            .foregroundColor(Color("wht"))
                            .opacity(0.75)
                        
                        
                        
                    }
                }
                .foregroundColor(Color("list_fill"))
            
            RoundedRectangle(cornerRadius: 24)
                .frame(width:.infinity, height:68)
                .foregroundColor(Color("list_fill"))
                .overlay(){
                    HStack(spacing : 16){
                        Circle()
                            .frame(width:36, height:36)
                            .foregroundColor(Color("Secondary"))
                        Text("2023.08.16")
                            .font(.system(size: 14).weight(.bold))
                            .foregroundColor(Color("wht"))
                            .opacity(0.75)
                        Text("1단계 문장 말하기...")
                            .font(.system(size: 14).weight(.bold))
                            .foregroundColor(Color("wht"))
                            .opacity(0.75)
                        Image(systemName: "arrow.right")
                            .font(.system(size: 20))
                            .foregroundColor(Color("wht"))
                            .opacity(0.75)
                        
                        
                        
                    }
                }
                .foregroundColor(Color("list_fill"))
            
            RoundedRectangle(cornerRadius: 24)
                .frame(width:.infinity, height:68)
                .foregroundColor(Color("list_fill"))
                .overlay(){
                    HStack(spacing : 16){
                        Circle()
                            .frame(width:36, height:36)
                            .foregroundColor(Color("Secondary"))
                        Text("2023.08.12")
                            .font(.system(size: 14).weight(.bold))
                            .foregroundColor(Color("wht"))
                            .opacity(0.75)
                        Text("1단계 문장 말하기...")
                            .font(.system(size: 14).weight(.bold))
                            .foregroundColor(Color("wht"))
                            .opacity(0.75)
                        Image(systemName: "arrow.right")
                            .font(.system(size: 20))
                            .foregroundColor(Color("wht"))
                            .opacity(0.75)
                        
                        
                        
                    }
                }
                .foregroundColor(Color("list_fill"))
        }
//        .padding(.horizontal, 16)
        // 여름에 가기로는 했는데, 덥거나 추우믄 다시 돌아오기
    }
}

struct HomeViewRecord_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewRecord()
    }
}
