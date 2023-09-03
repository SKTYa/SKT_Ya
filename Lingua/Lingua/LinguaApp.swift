//
//  LinguaApp.swift
//  Lingua
//
//  Created by 김다빈 on 2023/08/30.
//

import SwiftUI

@main
struct LinguaApp: App {
    var wordNetwork = NetworkManagerWord()
    var sentenceNetwork = NetworkManagerSentence()
    var paragraphNetwork = NetworkManagerParagraph()
    var audioManager = AudioRecorderManger()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(audioManager)
                .environmentObject(wordNetwork)
                .environmentObject(sentenceNetwork)
                .environmentObject(paragraphNetwork)
        }
    }
}
