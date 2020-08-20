//
//  AnswerRepository.swift
//  memo
//
//  Created by Elias Ferreira on 20/08/20.
//  Copyright © 2020 Academy IFCE. All rights reserved.
//

import Foundation

class AnswerRepository {
    static func search(word: String, completion: @escaping (Answer) -> Void) {
        // Create URL
        let url = URL(string: "https://owlbot.info/api/v4/dictionary/\(word)")!
        // Token
        let token = "759e405ad8b00ef1b057fb5e0ba3384b1437e4f4"
        // Create URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json",
            "Authorization": "Token \(token)"
        ]
        //request.setValue("Token \(token)", forHTTPHeaderField: "Authorization")
        // Create Session
        let session = URLSession(configuration: .default)
        
        let getRankingTask = session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                if let answer = try? JSONDecoder().decode(Answer.self, from: data) {
                    completion(answer)
                } else {
                    print("Erro no decode")
                    //completion([])
                }
            }
        }
        // Execute the task.
        getRankingTask.resume()
    }
}
