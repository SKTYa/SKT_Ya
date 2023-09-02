//
//  ParagraphSequenceFirst.swift
//  Lingua
//
//  Created by Jin Sang woo on 2023/08/31.
//

import SwiftUI

struct ParagraphProFirst: View {
    
    @Binding var currentSentenceIndex: Int // Use binding
    let sentences: [ParagraphSequneceView.Sentence]
    
    var body: some View {
        
        
        ZStack(){
            Color("BG").edgesIgnoringSafeArea(.all)
            
            ScrollView(){
                
                VStack(spacing : 34){
                    // 46
                    
                    //                    Spacer().frame(height:26)
                    
                    
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
                        
                        TTSBtn(ttsText: "권장발음")
                        
                        Spacer()
                    }
                    
                    HStack(){
                        
                        Text(sentences[currentSentenceIndex].recommendedText)
                            .foregroundColor(Color("wht"))
                            .font(.system(size: 34).weight(.bold))
                            .lineSpacing(10)
                        
                        Spacer()
                    }
                    .frame(maxWidth:365)
                    //                    .border(Color.green, width:2)
                    
                    Spacer().frame(height:12)
                    
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
                        Text(sentences[currentSentenceIndex].actualText)
                            .foregroundColor(Color("wht"))
                            .font(.system(size: 34).weight(.bold))
                            .lineSpacing(10)
                        
                        Spacer()
                        
                    }
                    .frame(maxWidth:365)
                    
                    //                    .border(Color.red, width:2)
                    
                    
                    
                }
                //                .border(Color.red, width:2)
                
            }
            
            .frame(width:.infinity, height:.infinity)
            .padding(16)
        }
    }
}

//struct ParagraphProFirst_Previews: PreviewProvider {
//    static var previews: some View {
//        ParagraphProFirst()
//    }
//}
