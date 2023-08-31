//
//  HomeViewTop.swift
//  Lingua
//
//  Created by Jin Sang woo on 2023/08/30.
//

import SwiftUI

struct HomeViewTop: View {
    var body: some View {
        
        HStack(){
            Text("김유빈님")
                .font(.system(size: 20).weight(.bold))
                .foregroundColor(Color("wht"))
            
            Spacer()
            
            Image(systemName: "bell.fill")
                .foregroundColor(Color("wht"))
                .font(.system(size: 22).weight(.bold))
                .bold()
            
            Spacer().frame(width: 16)
            
            
            Image(systemName: "person.crop.circle.fill")
                .foregroundColor(Color("wht"))
                .font(.system(size: 22).weight(.bold))
                .bold()
            
            
        }
        .frame(width:.infinity, height:67)
        .padding(8)
        
    }
}

struct HomeViewTop_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewTop()
    }
}
