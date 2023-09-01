//
//  HomeViewSpeak.swift
//  Lingua
//
//  Created by Jin Sang woo on 2023/08/30.
//

import SwiftUI

struct HomeViewSpeak: View {
    var body: some View {
        
        VStack(){
            HStack(spacing : 15){
                RoundedRectangle(cornerRadius: 24)
                    .frame(width:192, height:48)
                    .overlay(){
                        Text("2단계 문장 말하기")
                            .foregroundColor(Color("Primary"))
                            .font(.system(size: 20).weight(.bold))
                    }
                    .foregroundColor(Color("list_fill"))
//                    .border(Color("stroke"), width: 1)

                
                Text("학습 중입니다.")
                    .font(.system(size: 20).weight(.bold))
                    .foregroundColor(Color("wht"))
                    .frame(height:48)
                
                Spacer()
                
            }
            .frame(width:.infinity)
//            .border(Color.red, width: 2)

            
            Spacer().frame(height: 36)

        }
        
    }
}

struct HomeViewSpeak_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewSpeak()
    }
}
