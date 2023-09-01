//
//  ParagrphM.swift
//  Lingua
//
//  Created by doeun kim on 2023/09/01.
//

import Foundation

struct Paragraph: Decodable {
    let index: Int?
    let answerSpeed: Array<Int>?
    let sentence, breath: Array<String>?
}

struct CheckParagraph: Decodable {
    let time: Float?
    let similarity: Int?
    let text, breaths: Array<String>?
    let compared, origin: Array<Array<Int>>?
}
