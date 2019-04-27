//
//  NetworkManager.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 26/04/2019.
//  Copyright © 2019 MacBook-Игорь. All rights reserved.
//

import Foundation

struct API {
    static let scheme = "https"
    static let host = "api.vk.com"
    static let newsfeedPath = "/method/newsfeed.get"
    static let version = "5.95"
}

protocol Networking {
    func request(path: String, parameters: [String: String], complition: @escaping (Data?, Error?) -> Void)
}

final class NetworkManager: Networking {

    private let authService: AuthService! = AppDelegate.shared().authService
    
    private func createURL(path: String, parameters: [String: String]) -> URL? {
        
        var components = URLComponents()
        components.scheme = API.scheme
        components.host = API.host
        components.path = path
        components.queryItems = parameters.map {URLQueryItem(name: $0, value: $1)}
        
        guard let url = components.url else { return nil }
        print(url)
        return url
    }
    
    func request(path: String, parameters: [String : String], complition: @escaping (Data?, Error?) -> Void) {
        guard let token = authService.token else { return }
        
        var parameters = parameters
        parameters["access_token"] = token
        parameters["v"] = API.version
        
        guard let url = createURL(path: path, parameters: parameters) else { return }
        print(url)

        let session = URLSession.init(configuration: .default)
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                complition(data, error)
            }
        }
        task.resume()
    }
    
}
