////
////  PronounceView.swift
////  Lingua
////
////  Created by Jin Sang woo on 2023/08/31.
////
//
//import SwiftUI
//
//
//
//struct PronounceView: View {
//
//    @State private var rotation: Double = 0.0
//
//    @State private var selectedOptionIndex = 0
//    private let options = ["1단계 단어 말하기", "2단계 단어 말하기", "3단계 단어 말하기"]
//
//    @State private var selectedTab = 0
//
//    private let tabs = [
//        Tab(icon: nil, title: "발음"),
//        Tab(icon: nil, title: "호흡") // 아이콘이 없는 경우 nil로 설정합니다.
//    ]
//
//
//    var body: some View {
//
//        ZStack(){
//            Color("BG").edgesIgnoringSafeArea(.all)
//
//            VStack(){
//                HStack(spacing : 8){
//
//
//                    Image(systemName: "chevron.left")
//                        .foregroundColor(Color("wht"))
//                        .font(.system(size: 22).weight(.bold))
//                        .bold()
//
//                    Spacer()
//
//                    Menu {
//                        ForEach(options.indices, id: \.self) { index in
//                            Button(action: {
//                                selectedOptionIndex = index
//                            }) {
//                                RoundedRectangle(cornerRadius: 24)
//                                    .frame(width: 223, height:48)
//                                    .overlay(){
//                                        Text(options[index])
//                                            .foregroundColor(Color("Primary"))
//                                            .font(.system(size: 20).weight(.bold))
//
//                                    }
//                            }
//                            .foregroundColor(Color("list_fill"))
//                            .border(Color("stroke"), width: 1)
//
//
//
//                        }
//
//                    } label: {
//                        RoundedRectangle(cornerRadius: 24)
//                            .frame(width: 223, height:48)
//                            .overlay(){
//                                HStack(){
//                                    Text("2단계 문장 말하기")
//                                        .foregroundColor(Color("Primary"))
//                                        .font(.system(size: 20).weight(.bold))
//                                    Image(systemName: "chevron.down")
//                                        .foregroundColor(Color("wht"))
//                                        .font(.system(size: 20))
//
//                                }
//                            }
//                            .foregroundColor(Color("list_fill"))
//                            .border(Color("stroke"), width: 1)
//                    }
//                    Spacer()
//
//
//                    Image(systemName: "person.crop.circle.fill")
//                        .foregroundColor(Color("wht"))
//                        .font(.system(size: 22).weight(.bold))
//                        .bold()
//
//                }
//
//                Spacer()
//
//                VStack {
//                    Tabs(tabs: tabs, geoWidth: UIScreen.main.bounds.width, selectedTab: $selectedTab)
//
//                    if selectedTab == 0 {
//
//                        PronouncePronView()
//
//
////                        PronouncePronView()
//                    } else if selectedTab == 1 {
//                        PronounceBreath()
//                    }
//                }
//
//
//                HStack(){
//
//                    RoundedRectangle(cornerRadius: 24)
//                        .frame(width: 174, height:64)
//                        .overlay(){
//                            HStack(){
//                                Text("다음 문장")
//                                    .foregroundColor(Color("bk"))
//                                    .font(.system(size: 22).weight(.bold))
//                            }
//                        }
//                        .foregroundColor(Color("Primary"))
//                        .border(Color("stroke"), width: 1)
//
//                    RoundedRectangle(cornerRadius: 24)
//                        .frame(width: 88, height:64)
//                        .overlay(){
//                            HStack(){
//                                Text("완료")
//                                    .foregroundColor(Color("wht"))
//                                    .font(.system(size: 22).weight(.bold))
//                            }
//                        }
//                        .foregroundColor(Color("list_fill"))
//                        .border(Color("stroke"), width: 1)
//
//                    RoundedRectangle(cornerRadius: 24)
//                        .frame(width: 64, height:64)
//                        .overlay(){
//                            HStack(){
//                                Image(systemName: "bookmark")
//                                    .foregroundColor(Color("wht"))
//                                    .font(.system(size: 24).weight(.bold))
//                            }
//                        }
//                        .foregroundColor(Color("list_fill"))
//                        .border(Color("stroke"), width: 1)
//
//                }
//                .padding(16)
//
//
//            }
//
//        }
//
//    }
//}
//
//struct PronounceView_Previews: PreviewProvider {
//    static var previews: some View {
//        PronounceView()
//    }
//}

import SwiftUI

struct PronounceView: View {
    
    @State private var selectedOptionIndex = 0
    private let options = ["1단계 단어 말하기", "2단계 단어 말하기", "3단계 단어 말하기"]
    
    @State private var selectedTab = 0

//    private let tabs = [
//        Tab(icon: nil, title: "발음"),
//        Tab(icon: nil, title: "호흡") // 아이콘이 없는 경우 nil로 설정합니다.
//    ]
    
    
    var body: some View {

        ZStack(){
            Color("BG").edgesIgnoringSafeArea(.all)
            
            VStack(){
                HStack(spacing : 38){
                    
                    
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color("wht"))
                        .font(.system(size: 22).weight(.bold))
                        .frame(width:48, height:64)
                        .bold()
                    
                    
                    
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
                
                
                PronounceTab()
                

                
                HStack(){
                    
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
                                Image(systemName: "bookmark.fill")
                                    .foregroundColor(Color("bk"))
                                    .font(.system(size: 24).weight(.bold))
                            }
                        }
                        .foregroundColor(Color("Primary"))
                    
                }
                .padding(16)
                
                
            }
            
        }


    }
}

struct PronounceView_Previews: PreviewProvider {
    static var previews: some View {
        PronounceView()
    }
}
