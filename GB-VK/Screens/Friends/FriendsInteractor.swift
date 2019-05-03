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
    func prepareDataPassing(for userID: Int)
}


protocol FriendsDataStore {
    var userID: Int? { get set }
}

class FriendsInteractor: FriendsBusinessLogic, FriendsDataStore {
    
    var presenter: FriendsPresentationLogic?
    var service: FriendsService?
    private var searchManager = SearchingManager<Friend>()
    var userID: Int?
    
    func makeRequest(request: Friends.Model.Request.RequestType) {
        if service == nil {
            service = FriendsService()
        }
    
        switch request {
        case .getFriendsList(let alphabeticallySorted):
            presenter?.presentData(response: .presentFrieds(friends: friends, alphabeticallySorted: alphabeticallySorted))
        case .getFriendsListFiltered(let searchText, let target):
            searchManager.searchingFilter(for: searchText, in: target)
            presenter?.presentData(response: .presentFrieds(friends: searchManager.searchingResult, alphabeticallySorted: false))
        }
    }
    
    func prepareDataPassing(for userID: Int) {
        self.userID = userID
    }
}
