//
//  PronouncePronView.swift
//  Lingua
//
//  Created by Jin Sang woo on 2023/08/31.
//

import SwiftUI

struct PronouncePronView: View {
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
                        Text("높은 산 꼭대기에 작은 꽃이 피어있네요.")
                            .foregroundColor(Color("wht"))
                            .font(.system(size: 34).weight(.bold))
                            .lineSpacing(10)
                        Spacer()
                    }
                    
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
                        Text("높은 산 고때끼에 자은 곶이 피어있네요.")
                            .foregroundColor(Color("wht"))
                            .font(.system(size: 34).weight(.bold))
                            .lineSpacing(10)
                        Spacer()
                    }
                    
                }
            }
            .frame(width:358, height:474)
            .padding(16)
        }
        
        
//        VStack(){
//
//            HStack(spacing : 16){
//                RoundedRectangle(cornerRadius: 24)
//                    .frame(width: 88, height:40)
//                    .overlay(){
//                        HStack(){
//                            Text("권장 발음")
//                                .foregroundColor(Color("wht"))
//                                .font(.system(size: 14).weight(.bold))
//                        }
//                    }
//                    .foregroundColor(Color("list_fill"))
//                    .border(Color("stroke"), width: 1)
//
//                Circle()
//                    .overlay(){
//                        Image(systemName: "speaker.wave.2.fill")
//                            .foregroundColor(Color("wht"))
//
//                    }
//                    .foregroundColor(Color("list_fill"))
//                    .frame(width:40, height:40)
//
//                Spacer()
//            }
//            .padding(16)
//
//            Text("높은 산 꼭대기에 작은 꽃이 피어있네요.")
//                .foregroundColor(Color("wht"))
//                .font(.system(size: 34).weight(.bold))
//
//            HStack(spacing : 16){
//                RoundedRectangle(cornerRadius: 24)
//                    .frame(width: 88, height:40)
//                    .overlay(){
//                        HStack(){
//                            Text("실제 발음")
//                                .foregroundColor(Color("wht"))
//                                .font(.system(size: 14).weight(.bold))
//                        }
//                    }
//                    .foregroundColor(Color("list_fill"))
//                    .border(Color("stroke"), width: 1)
//
//                Circle()
//                    .overlay(){
//                        Image(systemName: "speaker.wave.2.fill")
//                            .foregroundColor(Color("wht"))
//
//                    }
//                    .foregroundColor(Color("list_fill"))
//                    .frame(width:40, height:40)
//
//                Spacer()
//            }
//            .padding(16)
//
//            Text("높은 산 고때끼에 자은 곶이 피어있네요.")
//                .foregroundColor(Color("wht"))
//                .font(.system(size: 34).weight(.bold))
//
//
//        }
//                        .padding(.leading, 16)
        
        
    }
}

struct PronouncePronView_Previews: PreviewProvider {
    static var previews: some View {
        PronouncePronView()
    }
}
