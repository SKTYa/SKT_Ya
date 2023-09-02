//
//  WordM.swift
//  Lingua
//
//  Created by doeun kim on 2023/09/01.
//

import Foundation

struct Word: Decodable {
    var wordSpeed, index: Int?
    var wordName: String?
}

struct CheckWord: Decodable {
    var time: Float?
    var similarity: Int?
    var text: String?
    var isCorrect: Bool?
}
