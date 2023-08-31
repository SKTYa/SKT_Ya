//
//  ParagraphBreFirst.swift
//  Lingua
//
//  Created by Jin Sang woo on 2023/08/31.
//

import SwiftUI

struct ParagraphBreFirst: View {
    
    @Binding var currentSentenceIndex: Int // Use binding
    let sentences: [ParagraphSequneceView.Sentence]
    
    var body: some View {

        ZStack(){
            Color("BG").edgesIgnoringSafeArea(.all)
            
            ScrollView(){
                
                VStack(spacing : 34){
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
                            .border(Color("stroke"), width: 1)
                        
                        Circle()
                            .overlay(){
                                Image(systemName: "speaker.wave.2.fill")
                                    .foregroundColor(Color("wht"))
                                
                            }
                            .foregroundColor(Color("list_fill"))
                            .frame(width:40, height:40)
                        
                        Spacer()
                    }
                    
                    
//                    Text("밝은 태양 아래에서 귀여운 강아지가 즐겁게 뛰고있어요.")
                    Text(sentences[currentSentenceIndex].recommendedText)
                        .foregroundColor(Color("wht"))
                        .font(.system(size: 34).weight(.bold))
                        .lineSpacing(10)
                    
                    Spacer().frame(height:12)

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
                            .border(Color("stroke"), width: 1)
                        
                        Circle()
                            .overlay(){
                                Image(systemName: "speaker.wave.2.fill")
                                    .foregroundColor(Color("wht"))
                                
                            }
                            .foregroundColor(Color("list_fill"))
                            .frame(width:40, height:40)
                        
                        Spacer()
                    }
                    
                    Text(sentences[currentSentenceIndex].actualText)
                        .foregroundColor(Color("wht"))
                        .font(.system(size: 34).weight(.bold))
                        .lineSpacing(10)

                    
                    
                }
                
            }
            .frame(width:358, height:425)
            .padding(16)
        }


    }
}

//struct ParagraphBreFirst_Previews: PreviewProvider {
//    static var previews: some View {
//        ParagraphBreFirst()
//    }
//}
