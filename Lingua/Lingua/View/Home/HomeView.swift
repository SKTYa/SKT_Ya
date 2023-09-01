//
//  HomeView.swift
//  Lingua
//
//  Created by Jin Sang woo on 2023/08/30.
//

import SwiftUI

struct HomeView: View {
    @StateObject var audioRecorderManger = AudioRecorderManger()
    var body: some View {
        
        NavigationView {

            
            ZStack {
                Color("BG").edgesIgnoringSafeArea(.all)
                // 전체 화면을 검은색으로 설정
                
                
                    
                    VStack(){
                        
                        HomeViewTop()
                        
                        HomeViewSpeak()
                        //                        .border(Color.blue, width: 2)
                        
                        HomeViewLearn()
                        
                        
                        
                        
                        HomeViewRecord()
                        
                        
                        Spacer()
                        
                        
                        
                        
                        
                        
                    }
                    //                .border(Color.green, width: 2)
                }
                
            }
        
            
            
        
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
