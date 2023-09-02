//
//  NetworkManagerWord.swift
//  Lingua
//
//  Created by doeun kim on 2023/09/01.
//

import Foundation
import SwiftUI
import Combine

class NetworkManagerWord: ObservableObject {
    @Published var words: Word = Word(wordSpeed: 0, index: 0, wordName: "")
    @Published var checkWords: CheckWord = CheckWord(time: 0.0, similarity: 0, text: "", isCorrect: false)
    
    func getWord(completion: @escaping (Word) -> ()) {
        guard let url = URL(string: "http://35.202.5.120:8000/get-word") else {
            print("Error: cannot create URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let defaultSession = URLSession(configuration: .default)
        
        defaultSession.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            guard error == nil else {
                print("Error occur: error calling POST - \(String(describing: error))")
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse, (200..<300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            
            guard let output = try? JSONDecoder().decode(Word.self, from: data) else {
                print("Error: JSON data parsing failed")
                return
            }
            completion(output)
            print("output: \n")
            print(output)
            self.words.wordName = output.wordName
            self.words.index = output.index
            self.words.wordSpeed = output.wordSpeed
            
            //            completionHandler(true, output.data)
        }.resume()
        
    }
    
    func checkWord(originStr : String, file: Data, completion: @escaping (CheckWord) -> ()) {
        // 서버 URL 설정
        var serverURL = URLComponents(string: "http://35.202.5.120:8000/check/word")!
        
        // 쿼리 매개변수 추가
        serverURL.queryItems = [
            URLQueryItem(name: "origin_str", value: originStr)
        ]
        
        // URL 생성
        guard let url = serverURL.url else {
            print("Invalid URL")
            return
        }
        let boundary = "Boundary-\(UUID().uuidString)"
        
        var request = URLRequest(url: url)
        print(request)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var body = Data()
        let boundaryPrefix = "--\(boundary)\r\n"
        
        body.append(boundaryPrefix.data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"inputAudio.m4a\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: application/octet-stream\r\n\r\n".data(using: .utf8)!)
        body.append(file)
        body.append("\r\n".data(using: .utf8)!)

        body.append(boundaryPrefix.data(using: .utf8)!)
        
        request.httpBody = body
        
        let defaultSession = URLSession(configuration: .default)
        
        defaultSession.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            guard error == nil else {
                print("Error occur: error calling POST - \(String(describing: error))")
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse, (200..<300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            
            print(data)
            
            guard let output = try? JSONDecoder().decode(CheckWord.self, from: data) else {
                print("Error: JSON data parsing failed")
                return
            }
            completion(output)
            print("output:")
            print(output)
            print(output.text?.utf8)
            
            self.checkWords.isCorrect = output.isCorrect
            self.checkWords.similarity = output.similarity
            self.checkWords.text = output.text
            self.checkWords.time = output.time
            
        }.resume()
        
    }
}
