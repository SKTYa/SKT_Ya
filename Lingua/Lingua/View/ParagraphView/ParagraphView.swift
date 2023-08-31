//
//  ParagraphView.swift
//  Lingua
//
//  Created by Jin Sang woo on 2023/08/31.
//

import SwiftUI

struct ParagraphView: View {
    
    @State private var selectedOptionIndex = 0
    private let options = ["1단계 단어 말하기", "2단계 단어 말하기", "3단계 단어 말하기"]
    
    
    var body: some View {

        ZStack(){
            Color("BG").edgesIgnoringSafeArea(.all)
            
            VStack(){
                HStack(spacing : 8){
                    
                    
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color("wht"))
                        .font(.system(size: 22).weight(.bold))
                        .bold()
                    
                    Spacer()
                    
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
                            .border(Color("stroke"), width: 1)
                            
                            
                            
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
                            .border(Color("stroke"), width: 1)
                    }
                    Spacer()
                    
                    
                    Image(systemName: "person.crop.circle.fill")
                        .foregroundColor(Color("wht"))
                        .font(.system(size: 22).weight(.bold))
                        .bold()
                    
                }
                
                //                Spacer().frame(height:30)
                
                
                VStack(){

                    LinearGradient(gradient: Gradient(stops: [
                        .init(color: Color("wht"), location: 0.6),
                        .init(color: Color.clear, location: 1)
                    ]), startPoint: .top, endPoint: .bottom)
                    .mask(
                        VStack(){
                            
                            Text("밝은 태양 아래에서 귀여운 강아지가 즐겁게 뛰고 있어요. 공을 물고 놀면서 즐거움을 표현하고, 작은 고양이는 나무 위에서 살짝 울리는 소리를 내고 있어요.")
                                .foregroundColor(Color("wht"))
                                .font(.system(size: 34).weight(.bold))
                                .bold()
                                .lineSpacing(10)
                                .frame(width:320)
                                .padding(.top)
                            
                            Spacer()
                        }
                    )
                }
                .border(Color.red, width:2)

                
                
                
                RoundedRectangle(cornerRadius: 24)
                    .frame(width: 259, height:58)
                    .overlay(){
                        HStack(){
                            
                            Image("Component1")
                                .resizable()
                                .frame(width : 46, height:41.954)
                            
                            
                            Text("지금 말해보세요.")
                                .foregroundColor(Color("Primary"))
                                .font(.system(size: 20).weight(.bold))
                            
                            
                        }
                        .padding()
                        
                    }
                    .foregroundColor(Color("list_fill"))
                    .border(Color("stroke"), width: 1)
                
                
                Spacer().frame(height:98)
                
                
                
                
                HStack(spacing : 75){
                    
                    Image("replay")
                        .resizable()
                        .frame(width:48, height:48)


                    Image("mic")
                        .resizable()
                        .frame(width:96, height:96)
                    
                    Image("black_arrow")
                        .resizable()
                        .frame(width:48, height:48)

                    
                }
                
                
                
            }
            
        }
        





    }
}

struct ParagraphView_Previews: PreviewProvider {
    static var previews: some View {
        ParagraphView()
    }
}
