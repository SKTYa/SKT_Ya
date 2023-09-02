//
//  PronounceBreath.swift
//  Lingua
//
//  Created by Jin Sang woo on 2023/08/31.
//

import SwiftUI

struct PronounceBreath: View {
    @State var selectedOptionIndex: Int
    @EnvironmentObject var wordNetwork: NetworkManagerWord
    @EnvironmentObject var sentenceNetwork: NetworkManagerSentence
    
    var body: some View {
        
        ZStack()
        {
            Color("BG").edgesIgnoringSafeArea(.all)
            
            ScrollView(.vertical){
                
                VStack(spacing : 26){
                    // 46
                    HStack(spacing : 16){
                        RoundedRectangle(cornerRadius: 24)
                            .frame(width: 88, height:40)
                            .overlay(){
                                HStack(){
                                    Text("권장 호흡")
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
                        if selectedOptionIndex == 1 {
                            ForEach( 0..<(sentenceNetwork.sentences.breath?.count ?? 0), id: \.self) { idx in
                                
                                if let sentence = sentenceNetwork.sentences.breath?[idx] {
                                    Text("\(sentence) \(Image(systemName: "pause.circle.fill"))")
                                        .foregroundColor(Color("wht"))
                                        .font(.system(size: 34).weight(.bold))
                                        .lineSpacing(10)
                                }
                                
                                
                            }
                        }
                        else if selectedOptionIndex == 0 {
                            Text("\(wordNetwork.words.wordName ?? "") \(Image(systemName: "pause.circle.fill"))")
                                .foregroundColor(Color("wht"))
                                .font(.system(size: 34).weight(.bold))
                                .lineSpacing(10)
                            
                        }
                        
                        Spacer()
                        
                    }
                    
                    Spacer().frame(height:20)
                    
                    HStack(spacing : 16){
                        RoundedRectangle(cornerRadius: 24)
                            .frame(width: 88, height:40)
                            .overlay(){
                                HStack(){
                                    Text("실제 호흡")
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
                        if selectedOptionIndex == 1 {
                            ForEach( 0..<(sentenceNetwork.checkSentences.breaths?.count ?? 0), id: \.self) { idx in
                                
                                if let sentence = sentenceNetwork.checkSentences.breaths?[idx] {
                                    Text("\(sentence) \(Image(systemName: "pause.circle.fill"))")
                                        .foregroundColor(Color("wht"))
                                        .font(.system(size: 34).weight(.bold))
                                        .lineSpacing(10)
                                }
                                
                                
                            }
                        }
                        else if selectedOptionIndex == 0 {
                            Text(wordNetwork.checkWords.text ?? "")
                                .foregroundColor(Color("wht"))
                                .font(.system(size: 34).weight(.bold))
                                .lineSpacing(10)
                            
                            Text("\(Image(systemName: "pause.circle.fill"))")
                                .foregroundColor(Color("wht"))
                                .font(.system(size: 34).weight(.bold))
                                .lineSpacing(10)
                            
                        }
                        Spacer()
                        
                    }
                    
                    
                }
            }
            .frame(width:358, height:474)
            .padding(16)
        }
        
    }
}

struct PronounceBreath_Previews: PreviewProvider {
    static var previews: some View {
        PronounceBreath(selectedOptionIndex: 0)
    }
}
