//
//  ParagraphSequneceView.swift
//  Lingua
//
//  Created by Jin Sang woo on 2023/08/31.
//

import SwiftUI



struct ParagraphSequneceView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var selectedOptionIndex = 2
    private let options = ["1단계 단어 말하기", "2단계 단어 말하기", "3단계 문단 말하기"]
    
    @State private var selectedTab = 0

    
    @State private var currentSentenceIndex = 0
    
    struct Sentence {
        let recommendedText: String
        let actualText: String
        let imageName: String
    }
    
    let sentences: [Sentence] = [
        Sentence(recommendedText: "밝은 태양 아래에서 귀여운 강아지가 즐겁게 뛰고있어요.", actualText: "밝은 태양 아래에서 커여운 강아지가 즐겁데 디거있어요.", imageName: "one"),
        Sentence(recommendedText: "내 근무 시간이 끝날 때까지, 내가 무슨 일을 하든, 내가 어디에 있든 항상.", actualText: "내 근무 시간이 끝날 때까지, 내가 무슨 일을 하든, 내가 어디에 있든 항상.", imageName: "two"),
        Sentence(recommendedText: "당신은 기다리지 않아도 됩니다.", actualText: "당신은 기다리지 않아도 됩니다.", imageName: "three"),
        Sentence(recommendedText: "저는 항상 여기에 있으니까요.", actualText: "저는 항상 여기에 있으니까요.", imageName: "four"),
        Sentence(recommendedText: "하지만, 당신이 저를 기다린다면, 저는 매우 감사합니다.", actualText: "하지만, 당신이 저를 기다린다면, 저는 매우 감사합니다.", imageName: "five"),
        Sentence(recommendedText: "왜냐하면, 그것이 바로 저의 존재 이유입니다.", actualText: "왜냐하면, 그것이 바로 저의 존재 이유입니다.", imageName: "six"),
        Sentence(recommendedText: "이렇게 오늘도 그대를 기다립니다.", actualText: "이렇게 오늘도 그대를 기다립니다.", imageName: "seven")
    ]
    
    
    var body: some View {

        ZStack(){
            Color("BG").edgesIgnoringSafeArea(.all)
            
            VStack(){
                
                
                HStack(spacing : 38){
                    
                    
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color("wht"))
                            .font(.system(size: 22).weight(.bold))
                            .frame(width:48, height:64)
                            .bold()
                    }

                  
                    
                    
                    
                    Menu {
                        ForEach(options.indices, id: \.self) { index in
                            Button(action: {
                                selectedOptionIndex = index
                            }) {
                                RoundedRectangle(cornerRadius: 24)
                                    .frame(width: 223, height:48)
                                    .overlay(){
                                        Text(options[index])
                                            .foregroundColor(Color("Primary"))
                                            .font(.system(size: 20).weight(.bold))
                                        
                                    }
                            }
                            .foregroundColor(Color("list_fill"))
                            
                            
                            
                        }
                        
                    } label: {
                        RoundedRectangle(cornerRadius: 24)
                            .frame(width: 223, height:48)
                            .overlay(){
                                HStack(){
                                    Text("2단계 문장 말하기")
                                        .foregroundColor(Color("Primary"))
                                        .font(.system(size: 20).weight(.bold))
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(Color("wht"))
                                        .font(.system(size: 20))
                                    
                                }
                            }
                            .foregroundColor(Color("list_fill"))
                    }

                    
                    
                    
                    Image(systemName: "person.crop.circle.fill")
                        .foregroundColor(Color("wht"))
                        .font(.system(size: 22).weight(.bold))
                        .bold()
                        .frame(width:27)
                    
                    
                }
                .frame(width:.infinity)
                .padding(.leading, -16)
                
                Spacer()
//
                
                ParagraphTab(currentSentenceIndex: $currentSentenceIndex,sentences:sentences)
                    .onAppear {
                        currentSentenceIndex = 0 // 처음에 첫 번째 문장 표시
                    }
                
                
                Image(sentences[currentSentenceIndex].imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height:24)
                    .padding(16)
                
                
                HStack(){
                    
                    Button(action: {
                        if currentSentenceIndex < sentences.count - 1 {
                            currentSentenceIndex += 1
                        }
                        print(currentSentenceIndex)
                    }) {
                        RoundedRectangle(cornerRadius: 24)
                            .frame(width: 174, height:64)
                            .overlay(){
                                HStack(){
                                    Text("다음 문장")
                                        .foregroundColor(Color("bk"))
                                        .font(.system(size: 22).weight(.bold))
                                }
                            }
                            .foregroundColor(Color("Primary"))
                    }
                    
                    RoundedRectangle(cornerRadius: 24)
                        .frame(width: 88, height:64)
                        .overlay(){
                            HStack(){
                                Text("완료")
                                    .foregroundColor(Color("wht"))
                                    .font(.system(size: 22).weight(.bold))
                            }
                        }
                        .foregroundColor(Color("list_fill"))
                    
                    RoundedRectangle(cornerRadius: 24)
                        .frame(width: 64, height:64)
                        .overlay(){
                            HStack(){
                                Image(systemName: "bookmark")
                                    .foregroundColor(Color("wht"))
                                    .font(.system(size: 24).weight(.bold))
                            }
                        }
                        .foregroundColor(Color("list_fill"))
                    
                }
                .padding(16)
                
                
            }
            
        }


    }
}

struct ParagraphSequneceView_Previews: PreviewProvider {
    static var previews: some View {
        ParagraphSequneceView()
    }
}
