//
//  FriendPhotosInteractor.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 29/04/2019.
//  Copyright (c) 2019 MacBook-Игорь. All rights reserved.
//

import UIKit

protocol FriendPhotosBusinessLogic {
  func makeRequest(request: FriendPhotos.Model.Request.RequestType)
}

protocol FriendPhotosDataStore {
    var userID: Int? { get set }
}

class FriendPhotosInteractor: FriendPhotosBusinessLogic, FriendPhotosDataStore {

    var presenter: FriendPhotosPresentationLogic?
    var service: FriendPhotosService?
    var userID: Int?
  
    func makeRequest(request: FriendPhotos.Model.Request.RequestType) {
        if service == nil {
            service = FriendPhotosService()
        }
        switch request {
        case .getFriendPhotos:
            if let user = friends.first(where: {$0.userID == userID}) {
                presenter?.presentData(response: .presentFriendPhotos(friend: user))
            }
        }
    }
    
}
