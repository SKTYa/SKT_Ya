//
//  NetworkManagerParagraph.swift
//  Lingua
//
//  Created by doeun kim on 2023/09/01.
//

import Foundation

class NetworkManagerParagraph: ObservableObject {
    @Published var paragraphs: [Paragraph] = []
    @Published var checkParagraphs: [CheckParagraph] = []
    
    func getParagraph(completion: @escaping (Paragraph) -> ()) {
        //        let requestBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        
        guard let url = URL(string: "http://127.0.0.1:8000/get-paragraph") else {
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
            
            guard let output = try? JSONDecoder().decode(Paragraph.self, from: data) else {
                print("Error: JSON data parsing failed")
                return
            }
            completion(output)
            print("output: \n")
            print(output)
            print(output.sentence)
            
            //            completionHandler(true, output.data)
        }.resume()
        
    }
    
    func checkParagraph(originStr : String, file: Data, completion: @escaping (CheckParagraph) -> ()) {
        // 서버 URL 설정
        var serverURL = URLComponents(string: "http://127.0.0.1:8000/check/paragraph")!
        
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
            
            guard let output = try? JSONDecoder().decode(CheckParagraph.self, from: data) else {
                print("Error: JSON data parsing failed")
                return
            }
            completion(output)
            print("output:")
            print(output)
            
        }.resume()
        
    }
    
}
