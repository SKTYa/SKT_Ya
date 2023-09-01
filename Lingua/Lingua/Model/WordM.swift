//
//  WordM.swift
//  Lingua
//
//  Created by doeun kim on 2023/09/01.
//

import Foundation

struct Word: Decodable {
    let wordSpeed, index: Int?
    let wordName: String?
}

struct CheckWord: Decodable {
    let time: Float?
    let similarity: Int?
    let text: String?
    let isCorrect: Bool?
}
