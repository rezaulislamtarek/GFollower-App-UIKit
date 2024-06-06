//
//  NetworkManager.swift
//  Github Follower UIKit
//
//  Created by Rezaul Islam on 6/6/24.
//

import Foundation

class NetworkManager{
    static let shared = NetworkManager()
    private let baseURL = "https://api.github.com/users/"
    private init(){ }
    
    func getFollowers(for userName: String, page: Int, completed : @escaping ([Follower]?, ErrorMessage?) -> Void ){
        let endpoint = baseURL + "\(userName)/followers?per_page=100&"
        guard let url = URL(string: endpoint) else {
            completed(nil, .invalidUserName)
            return
        }
        let task = URLSession.shared.dataTask(with: url){ (data, response, error) in
            if let _ = error{
                completed(nil, .unableToComplete)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                completed(nil, .invalidResponse)
                return
            }
            
            guard let data = data else {
                completed(nil,.invalidData)
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(followers, nil)
            }catch{
                completed(nil, .invalidData)
            }
            
        }
        task.resume()
    }
}
