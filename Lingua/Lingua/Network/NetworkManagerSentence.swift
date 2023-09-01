//
//  NetworkManagerSentence.swift
//  Lingua
//
//  Created by doeun kim on 2023/09/01.
//

import Foundation

class NetworkManagerSentence: ObservableObject {
    @Published var sentences: [Sentence] = []
    
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
            
            //            completionHandler(true, output.data)
        }.resume()
        
    }
}
