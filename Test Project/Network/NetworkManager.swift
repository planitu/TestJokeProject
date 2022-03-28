//
//  NetworkManager.swift
//  Test Project
//
//  Created by Максим Хоменко on 07.03.2022.
//

import Foundation

class NetworkManager {
    
    enum APIs: String {
        
        case jokeChuck = "https://geek-jokes.sameerkumar.website/api?format=json"
        case avitoTask = "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c"
    }
    
    
    func getModelFromURL<T:Codable>(get: T.Type, from urlOut: String, _ completion: @escaping (T) -> Void) {
        
        guard let url = URL(string: urlOut) else { print("url error!!!"); return }
    
        
        URLSession.shared.dataTask(with: url) {  data, _, error in
            
            guard let data = data, error == nil else { print(error.debugDescription);  return }
            
            guard let model = try? JSONDecoder().decode(T.self, from: data) else { print("JSondecoding errrror"); return }
            
            DispatchQueue.main.async {
                completion(model)
            }
        }.resume()
    }
}
