//
//  PronouncePronView.swift
//  Lingua
//
//  Created by Jin Sang woo on 2023/08/31.
//

import SwiftUI
import UIKit



struct PronouncePronView: View {
    @State var selectedOptionIndex: Int
    @EnvironmentObject var wordNetwork: NetworkManagerWord
    @EnvironmentObject var sentenceNetwork: NetworkManagerSentence
    @ObservedObject var audioRecorderManger: AudioRecorderManger

    
    var body: some View {
        ZStack(){
            Color("BG").edgesIgnoringSafeArea(.all)
            
            ScrollView(.vertical){
                
                
                
                VStack(spacing : 26){
                    // 46
                    HStack(spacing : 16){
                        RoundedRectangle(cornerRadius: 24)
                            .frame(width: 88, height:40)
                            .overlay(){
                                HStack(){
                                    Text("권장 발음")
                                        .foregroundColor(Color("wht"))
                                        .font(.system(size: 14).weight(.bold))
                                }
                            }
                            .foregroundColor(Color("list_fill"))
                        
                        if selectedOptionIndex == 0 {
                            TTSBtn(ttsText: self.wordNetwork.words.wordName ?? "")
                        }
                        else if selectedOptionIndex == 1 {
                            TTSBtn(ttsText: self.sentenceNetwork.sentences.sentence ?? "")
                        }
                        

                        
                        Spacer()
                    }
                    
                    
                    VStack(){
                        if selectedOptionIndex == 0 {
                            Text("\(self.wordNetwork.words.wordName ?? "")")
                                .foregroundColor(wordNetwork.checkWords.isCorrect ?? false ? Color("wht"):Color("Primary"))
                                .font(.system(size: 34).weight(.bold))
                                .lineSpacing(10)
                        }
                        else{
                            let text = sentenceNetwork.sentences.sentence!
                            let origin = sentenceNetwork.checkSentences.origin!
                            
                            //
                            
                            ForEach( 0..<text.count / 11, id: \.self) { i in
                                
                                let text_len = (text.count / 11 == i ? text.count % 11 : 11)
                                
                                HStack(spacing : 0){
                                    ForEach( 0..<text_len, id: \.self) { j in
                                        let idx = i * 11 + j
                                        
                                        let character = text[text.index(text.startIndex, offsetBy: idx)]
                                        
                                        Text(String(character))
                                            .padding(0)
                                            .foregroundColor(origin[idx] % 2 == 0 ? Color("wht") : Color("Primary"))
                                            .font(.system(size: 34).weight(.bold))
                                            .lineSpacing(10)
                                            .lineLimit(nil)
                                        
                                    }
                                    
                                }
                                //                                .frame(maxWidth : 358, maxHeight : .infinity)
//                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                                
                                
                                
                            }
                        }
                        
                        Spacer()
                    }
//                    .frame(maxWidth : .infinity, maxHeight : .infinity)
                    
                    Spacer().frame(height:20)
                    
                    HStack(spacing : 16){
                        RoundedRectangle(cornerRadius: 24)
                            .frame(width: 88, height:40)
                            .overlay(){
                                HStack(){
                                    Text("실제 발음")
                                        .foregroundColor(Color("wht"))
                                        .font(.system(size: 14).weight(.bold))
                                }
                            }
                            .foregroundColor(Color("list_fill"))
                        
                        Circle()
                            .overlay(){
                                Image(systemName: "speaker.wave.2.fill")
                                    .foregroundColor(Color("wht"))
                                
                            }
                            .foregroundColor(Color("list_fill"))
                            .frame(width:40, height:40)
                        
                        Spacer()
                    }
                    
                    VStack(){
                        if selectedOptionIndex == 0 {
                            Text(self.wordNetwork.checkWords.text ?? "")
                                .foregroundColor(wordNetwork.checkWords.isCorrect ?? false ? Color("wht"):Color("Wrong"))
                                .font(.system(size: 34).weight(.bold))
                                .lineSpacing(10)
                        }
                        else{
                            let text = sentenceNetwork.checkSentences.text!
                            let origin = sentenceNetwork.checkSentences.compared!
                            
                            
                            ForEach(0..<text.count / 11, id: \.self) { i in
                                let text_len = (text.count / 11 == i ? text.count % 11 : 11)

                                HStack(spacing: 0) { // spacing: 0으로 공백 없이 텍스트를 붙입니다.
                                    ForEach(0..<text_len, id: \.self) { j in
                                        let idx = i * 11 + j

                                        let character = text[text.index(text.startIndex, offsetBy: idx)]

                                        Text(String(character))
                                            .padding(0)
                                            .foregroundColor(origin[idx] % 2 == 0 ? Color("wht") : Color("Wrong"))
                                            .font(.system(size: 34).weight(.bold))
                                            .lineSpacing(10) // 텍스트 사이의 줄 간격을 조정합니다.
//                                            .lineLimit(1)
                                            .lineLimit(nil)
                                    }
                                }
//                                .frame(maxWidth : .infinity, maxHeight : .infinity)
                            }

                     
                        }
                        Spacer()
                    }
                    
                }
                .offset(y:50)
                
            }
            
            .frame(width:.infinity, height:.infinity)
            .padding(16)
            
            //            .introspectScrollView { scrollView in
            //                            scrollView.isDirectionalLockEnabled = true // 스와이프 비활성화
            //                        }
        }
        
        
        
    }
}









