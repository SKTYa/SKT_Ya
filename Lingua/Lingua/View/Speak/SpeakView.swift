//  SpeakView.swift
//  Lingua
//
//  Created by Jin Sang woo on 2023/08/30.
//

import SwiftUI

//struct RedBorderMenuStyle : MenuStyle {
//    func makeBody(configuration: Configuration) -> some View {
//        Menu(configuration)
//            .padding(3)
//            .border(Color.red)
//    }
//}

//extension Menu {
//    func menuButtonStyle() -> some View {
//        self.menuStyle(MenuButtonStyle())
//    }
//}

//struct MenuButtonStyle: MenuStyle{
//
//    func makeBody(configuration: Configuration) -> some View {
//        Menu(configuration)
//                    .padding()
//                    .foregroundColor(.green)
//                    .background(
//                        RoundedRectangle(cornerRadius: 8, style: .continuous)
//                            .foregroundColor(Color.blue)
//                    )
//    }
//
//}


struct SpeakView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var audioRecorderManger: AudioRecorderManger
    @EnvironmentObject var wordNetwork: NetworkManagerWord
    @EnvironmentObject var sentenceNetwork: NetworkManagerSentence
    @State private var isAnimate = true
    @State private var word = ""
    @State private var sentence = ""
    @State private var selectedOptionIndex = 1
    @State private var imageIndex = 0
    @State private var isLoading = false
    @State private var isResult = false
    private let options = ["1단계 단어 말하기", "2단계 문장 말하기", "3단계 문단 말하기"]
    private let waveImages = ["wave1","wave2","wave3","wave4","wave5"]
    
    @State private var animateMedium = false
    @State private var rotation: Double = 0.0
    
    
    var body: some View {
        ZStack {
            if isLoading {
                AnalyzeView()
            }
            else if isResult {
                PronounceView(selectedOptionIndex: selectedOptionIndex)
            }
            else {
                Color("BG").edgesIgnoringSafeArea(.all)
                
                VStack(){
                    
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
                                            //                                            .modifier(CustomTextModifier()) // 커스텀 스타일 적용
                                            
                                            //                                            .foregroundColor(Color("Primary"))
                                            //                                            .font(.system(size: 20).weight(.bold))
                                            //
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
                            
                        }
                        
                        
                        
                        Spacer()
                        
                        
                        Image(systemName: "person.crop.circle.fill")
                            .foregroundColor(Color("wht"))
                            .font(.system(size: 22).weight(.bold))
                            .bold()
                        
                    }
                    
                    
                    
                    //                Spacer().frame(height:147)
                    // 임시
                    
                    
                    
                    if selectedOptionIndex == 0 {
                        if word == "" {
                            
                            
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
                            
                            //                        Text("")
                            //                            .foregroundColor(Color("wht"))
                            //                            .font(.system(size: 34).weight(.bold))
                        }
                        else{
                            Spacer().frame(height:170.5)
                            
                            Text("\(word)")
                                .foregroundColor(Color("wht"))
                                .font(.system(size: 34).weight(.bold))
                        }
                    }
                    else {
                        if sentence == "" {
                            
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
                            
                            //
                        }
                        else{
                            
                            Spacer().frame(height:170.5)
                            
                            
                            Text("\(sentence)")
                                .foregroundColor(Color("wht"))
                                .font(.system(size: 34).weight(.bold))
                        }
                    }
                    
                    Spacer().frame(height:70)
                    
                    
                    RoundedRectangle(cornerRadius: 24)
                        .frame(width: 259, height:58)
                        .overlay(){
                            HStack(){
                                
                                Image("robot_black")
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
                    
                    
                    Spacer().frame(height:98)
                    
                    
                    HStack(spacing : 75){
                        
                        Button {
                            audioRecorderManger.isRecording ? audioRecorderManger.stopRecording() : audioRecorderManger.startRecording()
                        } label: {
                            Image("replay")
                                .resizable()
                                .frame(width:48, height:48)
                        }
                        
                        Button {
                            audioRecorderManger.isRecording ? audioRecorderManger.stopRecording() : audioRecorderManger.startRecording()
                        } label: {
                            if audioRecorderManger.isRecording == false {
                                Circle()
                                    .frame(width:96, height:96)
                                    .foregroundColor(Color("Primary"))
                                    .overlay() {
                                        Image(systemName: "mic")
                                            .font(.system(size: 30,weight: .bold))
                                            .foregroundColor(.black)
                                    }
                                
                            }
                            else {
                                
                                Circle()
                                    .foregroundColor(Color("Primary"))
                                    .frame(width: 96,height: 96)
                                    .overlay() {
                                        Image(waveImages[imageIndex])
                                            .resizable()
                                            .frame(width: 70,height: 30)
                                            .onAppear {
                                                
                                                // 0.5초마다 이미지 인덱스를 증가시키고, 배열 크기를 벗어나면 처음으로 되돌립니다.
                                                Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
                                                    withAnimation {
                                                        if imageIndex < waveImages.count - 1 {
                                                            imageIndex += 1
                                                        } else {
                                                            imageIndex = 0
                                                        }
                                                    }
                                                }
                                            }
                                        
                                        Circle()
                                            .stroke(Color("Primary").opacity(0.1), lineWidth: 2)
                                            .frame(width: isAnimate ? 96 : 242, height: isAnimate ? 96 : 242)
                                            .animation(Animation.linear(duration: 1).repeatForever(autoreverses: true))
                                            .onAppear() {
                                                isAnimate.toggle()
                                            }
                                        
                                        Circle()
                                            .stroke(Color("Primary").opacity(0.25), lineWidth: 2)
                                            .frame(width: isAnimate ? 96 : 198, height: isAnimate ? 96 : 198)
                                            .scaleEffect(animateMedium ? 1.2 : 1, anchor: .center)
                                            .animation(Animation.easeOut(duration: 1).repeatForever(autoreverses: true).delay(0.4))
                                            .onAppear() {
                                                self.animateMedium.toggle()
                                            }
                                        //                                        .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true))
                                        
                                        Circle()
                                            .stroke(Color("Primary").opacity(0.5), lineWidth: 2)
                                            .frame(width: isAnimate ? 96 : 154, height: isAnimate ? 96 : 154)
                                            .scaleEffect(animateMedium ? 1.6 : 0.8, anchor: .center)
                                            .animation(Animation.easeOut(duration: 1).repeatForever(autoreverses: true).delay(0.4))
                                            .onAppear() {
                                                self.animateMedium.toggle()
                                            }
                                        
                                        //                                        .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true))
                                        
                                    }
                                
                                
                                
                            }
                            
                            
                            
                        }
                        // TODO:
                        Button {
                            let group = DispatchGroup()
                            
                            if selectedOptionIndex == 0 {
                                self.isLoading = true
                                wordNetwork.checkWord(originStr: word, file: try! Data(contentsOf: audioRecorderManger.recordedFiles[0])){
                                    words in DispatchQueue.main.async(group: group) {
                                        self.isLoading = false
                                        self.isResult = true
                                        //                                        word = words.text ?? ""
                                        
                                    }
                                }
                            }
                            else{
                                self.isLoading = true
                                sentenceNetwork.checkSentence(originStr: sentence, file: try! Data(contentsOf: audioRecorderManger.recordedFiles[0])){
                                    sentences in DispatchQueue.main.async(group: group) {
                                        //                                        sentence = sentences.text ?? ""
                                        //                                            NavigationLink(destination: ResultView()) {}
                                        self.isLoading = false
                                        self.isResult = true
                                        print(sentenceNetwork.checkSentences)
                                    }
                                }
                                
                            }
                            print("nextPage")
                        } label: {
                            Image("black_arrow")
                                .resizable()
                                .frame(width:48, height:48)
                        }
                        
                        
                        
                        
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

