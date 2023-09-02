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
                        
                        Circle()
                            .overlay(){
                                Image(systemName: "speaker.wave.2.fill")
                                    .foregroundColor(Color("wht"))
                                
                            }
                            .foregroundColor(Color("list_fill"))
                            .frame(width:40, height:40)
                        
                        Spacer()
                    }
                    
                    
                    HStack(){
                        if selectedOptionIndex == 0 {
                            Text("\(self.wordNetwork.words.wordName ?? "")")
                                .foregroundColor(wordNetwork.checkWords.isCorrect ?? false ? Color("wht"):Color("Primary"))
                                .font(.system(size: 34).weight(.bold))
                                .lineSpacing(10)
                        }
                        else{
                            let text = sentenceNetwork.sentences.sentence!
                            let origin = sentenceNetwork.checkSentences.origin!
                            
                            ForEach(0..<text.count, id: \.self) { idx in
                                let character = text[text.index(text.startIndex, offsetBy: idx)]
                                
                                Text(String(character))
                                    .padding(0)
                                    .frame(width: 24)
                                    .foregroundColor(origin[idx] % 2 == 0 ? Color("wht") : Color("Primary"))
                                    .font(.system(size: 34).weight(.bold))
                            }
                            
                            //                            ForEach( 0..<text.count / 10, id: \.self) { i in
                            //
                            //                                let text_len = (text.count / 10 - 1 == i ? text.count % 10 : 10)
                            //
                            //                                HStack{
                            //                                    ForEach( 0..<text_len, id: \.self) { j in
                            //                                        let idx = i * 10 + j
                            //
                            //                                        let character = text[text.index(text.startIndex, offsetBy: idx)]
                            //
                            //                                        Text(String(character))
                            //                                            .padding(0)
                            //                                            .foregroundColor(origin[idx] % 2 == 0 ? Color("wht") : Color("Primary"))
                            //                                            .font(.system(size: 34).weight(.bold))
                            //                                        //                                    .lineSpacing(10)
                            //
                            //                                    }
                            //                                }
                            //
                            //
                            //                            }
                            
                            //                                                        Text("\(self.sentenceNetwork.sentences.sentence ?? "")")
                            //                                                            .foregroundColor(Color("wht"))
                            //                                                            .font(.system(size: 34).weight(.bold))
                            //                                                            .lineSpacing(10)
                        }
                        
                        Spacer()
                    }
                    .frame(width: 358)
                    
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
                    
                    HStack(){
                        if selectedOptionIndex == 0 {
                            Text(self.wordNetwork.checkWords.text ?? "")
                                .foregroundColor(wordNetwork.checkWords.isCorrect ?? false ? Color("wht"):Color("Wrong"))
                                .font(.system(size: 34).weight(.bold))
                                .lineSpacing(10)
                        }
                        else{
                            Text("\(self.sentenceNetwork.checkSentences.text ?? "")")
                                .foregroundColor(Color("wht"))
                                .font(.system(size: 34).weight(.bold))
                                .lineSpacing(10)
                        }
                        Spacer()
                    }
                    
                }
                .offset(y:50)
                
            }
            
            .frame(width:358, height:474)
            .padding(16)
            
            //            .introspectScrollView { scrollView in
            //                            scrollView.isDirectionalLockEnabled = true // 스와이프 비활성화
            //                        }
        }
        
        
        
    }
}









struct PronouncePronView_Previews: PreviewProvider {
    static var previews: some View {
        PronouncePronView(selectedOptionIndex: 0)
    }
}
