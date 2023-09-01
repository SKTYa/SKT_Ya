//
//  SentenceM.swift
//  Lingua
//
//  Created by doeun kim on 2023/09/01.
//

import Foundation

struct Sentence: Decodable {
    let answerSpeed, index: Int?
    let sentence: String?
    let breath: Array<String>?
}

struct CheckSentence: Decodable {
    let time: Float?
    let similarity: Int?
    let text: String?
    let breaths: Array<String>?
    let compared: Array<Int>?
    let origin: Array<Int>?
}
