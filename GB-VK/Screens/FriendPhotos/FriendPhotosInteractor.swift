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

class FriendPhotosInteractor: FriendPhotosBusinessLogic {

  var presenter: FriendPhotosPresentationLogic?
  var service: FriendPhotosService?
  
  func makeRequest(request: FriendPhotos.Model.Request.RequestType) {
    if service == nil {
      service = FriendPhotosService()
    }
    switch request {
    case .getFriendPhotos:
        print()
//        presenter?.presentData(response: .presentFriendPhotos(friend: friend))
    }
  }
  
}
