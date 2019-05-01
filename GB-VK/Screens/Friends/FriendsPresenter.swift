//
//  FriendsPresenter.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 26/04/2019.
//  Copyright (c) 2019 MacBook-Игорь. All rights reserved.
//

import UIKit

protocol FriendsPresentationLogic {
    func presentData(response: Friends.Model.Response.ResponseType)
}

class FriendsPresenter: FriendsPresentationLogic {
    
    weak var viewController: FriendsDisplayLogic?
    let sortManager = FriendsService()
    
    func presentData(response: Friends.Model.Response.ResponseType) {
        switch response {
        case .presentFrieds(let friends):
            let viewModel = sortManager.getFriendsList(friends)
            viewController?.displayData(viewModel: .displayFriends(viewModel: viewModel))
        }
    }
}
