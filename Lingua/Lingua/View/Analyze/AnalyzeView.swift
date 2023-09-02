//
//  AnalyzeView.swift
//  Lingua
//
//  Created by Jin Sang woo on 2023/08/30.
//

import SwiftUI

struct AnalyzeView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var rotation: Double = 0.0
    
    @State private var selectedOptionIndex = 0
    private let options = ["1단계 단어 말하기", "2단계 단어 말하기", "3단계 단어 말하기"]
    
    
    var body: some View {
        ZStack(alignment: .top) {
            Color("BG").edgesIgnoringSafeArea(.all)
            
            
            VStack {
                
                HStack(spacing : 8){
                    
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color("wht"))
                            .font(.system(size: 22).weight(.bold))
                            .bold()
                        
                    }

                    
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
                        Spacer()
                        
                        
                        Image(systemName: "person.crop.circle.fill")
                            .foregroundColor(Color("wht"))
                            .font(.system(size: 22).weight(.bold))
                            .bold()
                        
                        
                    
                }
                
                
                Spacer().frame(height:140)
                
                Image("oneone")
                    .resizable()
                    .frame(width: 219, height: 192)
                    .rotationEffect(.degrees(rotation))
                    .animation(Animation.linear(duration: 10).repeatForever(autoreverses: false))
                        .onAppear() {
                            withAnimation {
                                rotation += 1200
                            }
                        }
//                    .animation(.linear(duration: 1))

//                    .onTapGesture {
//                        rotation += 360
//                    }
                
                Spacer().frame(height:70)

                
                RoundedRectangle(cornerRadius: 24)
                    .frame(width: 259, height:58)
                    .overlay(){
                        HStack(){
                            
                            Image("robot_black")
                                .resizable()
                                .frame(width : 46, height:41.954)
                            
                            
                            Text("AI가 분석중이에요.")
                                .foregroundColor(Color("Primary"))
                                .font(.system(size: 20).weight(.bold))
                            
                            
                        }
                        .padding()
                        
                    }
                    .foregroundColor(Color("list_fill"))
                
                Spacer()
                
            }
                
            
        }
        
    }
}

struct AnalyzeView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyzeView()
    }
}
