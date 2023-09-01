//
//  SpeakView.swift
//  Lingua
//
//  Created by Jin Sang woo on 2023/08/30.
//

import SwiftUI

struct SpeakView: View {
    @ObservedObject var audioRecorderManger: AudioRecorderManger
    @EnvironmentObject var wordNetwork: NetworkManagerWord
    @EnvironmentObject var sentenceNetwork: NetworkManagerSentence
    @State private var isAnimate = false
    @State private var word = ""
    @State private var sentence = ""
    @State private var selectedOptionIndex = 1
    private let options = ["1단계 단어 말하기", "2단계 문장 말하기", "3단계 문단 말하기"]
    
    
    var body: some View {
        
        ZStack {
            Color("BG").edgesIgnoringSafeArea(.all)
            
            
            VStack(){
                
                HStack(spacing : 8){
                    
                    
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color("wht"))
                        .font(.system(size: 22).weight(.bold))
                        .bold()
                    
                    Spacer()
                    
                    //                    RoundedRectangle(cornerRadius: 24)
                    //                        .frame(width: 223, height:48)
                    //                        .overlay(){
                    //                            HStack(){
                    //                                Text("2단계 문장 말하기")
                    //                                    .foregroundColor(Color("Primary"))
                    //                                    .font(.system(size: 20).weight(.bold))
                    //                                Image(systemName: "chevron.down")
                    //                                    .foregroundColor(Color("wht"))
                    //                                    .font(.system(size: 20))
                    //
                    //                            }
                    //                        }
                    //                        .foregroundColor(Color("list_fill"))
                    //                        .border(Color("stroke"), width: 1)
                    //                        .contextMenu{
                    //                            VStack{
                    //                                Button(action: {
                    //                                            print("1단계 문장 말하기 선택됨")
                    //                                        }) {
                    //                                            Text("1단계 문장 말하기")
                    //                                                .foregroundColor(Color("Primary"))
                    //                                                .font(.system(size: 20).weight(.bold))
                    //                                        }
                    //                                Button(action: {
                    //                                            print("1단계 문장 말하기 선택됨")
                    //                                        }) {
                    //                                            Text("1단계 문장 말하기")
                    //                                                .foregroundColor(Color("Primary"))
                    //                                                .font(.system(size: 20).weight(.bold))
                    //                                        }
                    //                                Button(action: {
                    //                                            print("1단계 문장 말하기 선택됨")
                    //                                        }) {
                    //                                            Text("1단계 문장 말하기")
                    //                                                .foregroundColor(Color("Primary"))
                    //                                                .font(.system(size: 20).weight(.bold))
                    //                                        }
                    //                            }
                    //
                    //                        }
                    
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
                //                .frame(width:.infinity)
                //                .border(Color.red, width: 2)
                
                
                Spacer().frame(height:170.5)
                // 임시
                
                
                
                //                Text("높은 산 꼭대기에\n작은 꽃이 피어있네요.")
                if selectedOptionIndex == 0 {
                    if word == "" {
                        Text("")
                            .foregroundColor(Color("wht"))
                            .font(.system(size: 34).weight(.bold))
                    }
                    else{
                        Text("\(word)")
                            .foregroundColor(Color("wht"))
                            .font(.system(size: 34).weight(.bold))
                    }
                }
                else {
                    if sentence == "" {
                        Text("")
                            .foregroundColor(Color("wht"))
                            .font(.system(size: 34).weight(.bold))
                    }
                    else{
                        Text("\(sentence)")
                            .foregroundColor(Color("wht"))
                            .font(.system(size: 34).weight(.bold))
                    }
                }
                
                
                Spacer().frame(height:130)
                
                
                RoundedRectangle(cornerRadius: 24)
                    .frame(width: 259, height:58)
                    .overlay(){
                        HStack(){
                            
                            Image("Component 1")
                                .resizable()
                                .opacity(0.5)
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
                    
                    Button {
                        audioRecorderManger.isRecording ? audioRecorderManger.stopRecording() : audioRecorderManger.startRecording()
                        isAnimate.toggle()
                    } label: {
                        Image("replay")
                            .resizable()
                            .frame(width:48, height:48)
                    }
                    
                    Button {
                        audioRecorderManger.isRecording ? audioRecorderManger.stopRecording() : audioRecorderManger.startRecording()
                        isAnimate.toggle()
                    } label: {
                        if audioRecorderManger.isRecording == false {
                            Image("mic")
                                .resizable()
                                .frame(width:96, height:96)
                        }
                        else {
                            ZStack {
                                Circle()
                                    .stroke(Color("Primary").opacity(0.1), lineWidth: 1)
                                    .foregroundColor(.clear)
                                    .frame(width: isAnimate ? 96 : 198 ,height: isAnimate ? 96 : 198)
                                    .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true))
                                Circle()
                                    .stroke(Color("Primary").opacity(0.25), lineWidth: 1)
                                    .foregroundColor(.clear)
                                    .frame(width: isAnimate ? 96 : 154 ,height: isAnimate ? 96 : 154)
                                    .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true))
                                Circle()
                                    .stroke(Color("Primary").opacity(0.5), lineWidth: 1)
                                    .foregroundColor(.clear)
                                    .frame(width: isAnimate ? 96 : 118 ,height: isAnimate ? 96 : 118)
                                    .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true))
                                
                                Image("voice")
                                    .resizable()
                                    .foregroundColor(.red)
                                    .frame(width: 96,height: 96)
    
                                    
    
                            }
                            
                        }
                       
                    }

                    Button {
                        print("nextPage")
                    } label: {
                        Image("black_arrow")
                            .resizable()
                            .frame(width:48, height:48)
                    }

                  
                    
                    
                }
                
                
                
                
            }
            
            
            
        }
        .navigationBarBackButtonHidden(true)
        .onAppear{
            let group = DispatchGroup()
            
            if selectedOptionIndex == 0 {
                wordNetwork.getWord{
                    words in DispatchQueue.main.async(group: group) {
                        word = words.wordName ?? ""
                    }
                }
            }
            else{
                sentenceNetwork.getSentence{
                    sentences in DispatchQueue.main.async(group: group) {
                        sentence = sentences.sentence ?? ""
                    }
                }
            }
           
            
        }
        
        
        
        
    }
    
    
    
}
//
//struct SpeakView_Previews: PreviewProvider {
//    static var previews: some View {
//        SpeakView(audioRecorderManger:AudioRecorderManger)
//    }
//}
