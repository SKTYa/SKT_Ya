//
//  NetworkManagerSentence.swift
//  Lingua
//
//  Created by doeun kim on 2023/09/01.
//

import Foundation

class NetworkManagerSentence: ObservableObject {
    @Published var sentences: Sentence = Sentence(answerSpeed: 0, index: 0, sentence: "", breath: [])
    @Published var checkSentences: CheckSentence = CheckSentence(time: 0.0, similarity: 0, text: "", breaths: [], compared: [], origin: [])
    
    func getSentence(completion: @escaping (Sentence) -> ()) {
        //        let requestBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        
        guard let url = URL(string: "http://127.0.0.1:8000/get-sentence") else {
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
            
            guard let output = try? JSONDecoder().decode(Sentence.self, from: data) else {
                print("Error: JSON data parsing failed")
                return
            }
            completion(output)
            print("output: \n")
            print(output)
            print(output.sentence)
            
            self.sentences = output
            
            //            completionHandler(true, output.data)
        }.resume()
        
    }
    
    func checkSentence(originStr : String, file: Data, completion: @escaping (CheckSentence) -> ()) {
        // 서버 URL 설정
        var serverURL = URLComponents(string: "http://127.0.0.1:8000/check/sentence")!
        
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
            
            guard let output = try? JSONDecoder().decode(CheckSentence.self, from: data) else {
                print("Error: JSON data parsing failed")
                return
            }
            completion(output)
            print("output:")
            print(output)
            print(output.text?.utf8)
            
            self.checkSentences =  output
            
        }.resume()
        
    }
}
