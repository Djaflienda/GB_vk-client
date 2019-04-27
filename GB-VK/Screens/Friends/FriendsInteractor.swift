//
//  FriendsInteractor.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 26/04/2019.
//  Copyright (c) 2019 MacBook-Игорь. All rights reserved.
//

import UIKit

protocol FriendsBusinessLogic {
  func makeRequest(request: Friends.Model.Request.RequestType)
}

class FriendsInteractor: FriendsBusinessLogic {

  var presenter: FriendsPresentationLogic?
  var service: FriendsService?
    private var searchManager = SearchingManager<Friend>()
  
  func makeRequest(request: Friends.Model.Request.RequestType) {
    if service == nil {
      service = FriendsService()
    }
    
    switch request {
    case .getFriendsList:
        presenter?.presentData(response: .presentFrieds(friends: friends))
    case .getFriendsListFiltered(let searchText, let target):
        searchManager.searchingFilter(for: searchText, in: target)
        presenter?.presentData(response: .presentFrieds(friends: searchManager.searchingResult))
    @unknown default:
        print("add new case")
    }
    }
}
