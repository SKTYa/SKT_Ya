//
//  PronounceBreath.swift
//  Lingua
//
//  Created by Jin Sang woo on 2023/08/31.
//

import SwiftUI
import AVFoundation



struct PronounceBreath: View {
    @State var selectedOptionIndex: Int
    @EnvironmentObject var wordNetwork: NetworkManagerWord
    @EnvironmentObject var sentenceNetwork: NetworkManagerSentence
    @ObservedObject var audioRecorderManger: AudioRecorderManger
    

    let audioFileName = "recordedAudio.m4a"
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

                        if selectedOptionIndex == 0 {
                            TTSBtn(ttsText: self.wordNetwork.words.wordName ?? "")
                        }
                        else if selectedOptionIndex == 1 {
                            TTSBtn(ttsText: self.sentenceNetwork.sentences.sentence ?? "")
                        }
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
                        Button {
                            if audioRecorderManger.isPlaying &&
                                audioRecorderManger.audioPlayer?.url == audioRecorderManger.recordedFiles.first {
                                audioRecorderManger.isPaused ? audioRecorderManger.resumePlaying()
                                : audioRecorderManger.pausePlaying()
                            } else {
                                print("\(audioRecorderManger.recordedFiles)")
                                audioRecorderManger.startPlaying(recordingURL: audioRecorderManger.recordedFiles[0])
                            }
                      

                        } label: {
                            Circle()
                                .overlay(){
                                    Image(systemName: "speaker.wave.2.fill")
                                        .foregroundColor(Color("wht"))

                                }
                                .foregroundColor(Color("list_fill"))
                                .frame(width:40, height:40)
                        }

                      

                        Spacer()
                    }

                    HStack(spacing : 0){
                        if selectedOptionIndex == 1 {
                            ForEach( 0..<(sentenceNetwork.checkSentences.breaths?.count ?? 0), id: \.self) { idx in
                                
                                if let sentence = sentenceNetwork.checkSentences.breaths?[idx] {
                                    Text("\(sentence) \(Image(systemName: "pause.circle.fill"))")
                                        .foregroundColor(Color("wht"))
                                        .font(.system(size: 34).weight(.bold))
                                        .lineSpacing(10)
                                        .multilineTextAlignment(.center)
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
                .onTapGesture {} // 빈 제스처 추가로 스와이프 비활성화

            }
            
            .frame(width:.infinity, height:.infinity)
            .padding(16)
        }
        .onAppear {
           
        }

    }
}

