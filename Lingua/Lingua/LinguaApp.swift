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
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(wordNetwork)
                .environmentObject(sentenceNetwork)
        }
    }
}
