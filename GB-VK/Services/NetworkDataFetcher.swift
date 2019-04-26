//
//  NetworkDataFetcher.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 26/04/2019.
//  Copyright © 2019 MacBook-Игорь. All rights reserved.
//

import Foundation

protocol DataFetcher {
    func getNewsfeed(response: @escaping (NewsfeedResponse?)->Void)
}

struct NetworkDataFetcher: DataFetcher {
    
    let networkingManager: Networking
    
    init(networking: Networking) {
        self.networkingManager = networking
    }
    
    func getNewsfeed(response: @escaping (NewsfeedResponse?) -> Void) {
        let parameters = ["filters": "post, photo"]
        networkingManager.request(path: API.newsfeedPath, parameters: parameters) { (data, error) in
            if let error = error {
                print("\(error.localizedDescription)")
                response(nil)
            }
            let decoded = self.decodeJSON(type: NewsfeedResponseWrapped.self, from: data)
            response(decoded?.response)
        }
    }
    
    private func decodeJSON<T:Codable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = from, let response = try? decoder.decode(type.self, from: data) else {return nil}
        return response
    }
}
