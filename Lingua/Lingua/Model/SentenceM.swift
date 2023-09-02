//
//  SentenceM.swift
//  Lingua
//
//  Created by doeun kim on 2023/09/01.
//

import Foundation

struct Sentence: Decodable {
    var answerSpeed, index: Int?
    var sentence: String?
    var breath: Array<String>?
}

struct CheckSentence: Decodable {
    var time: Float?
    var similarity: Int?
    var text: String?
    var breaths: Array<String>?
    var compared: Array<Int>?
    var origin: Array<Int>?
}
