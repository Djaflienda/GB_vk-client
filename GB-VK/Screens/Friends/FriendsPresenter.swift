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
  
  func presentData(response: Friends.Model.Response.ResponseType) {
    switch response {
    case .presentFrieds(let friends):
        let cells = friends.map { (friend) in
            cellViewModel(from: friend)
        }
        
        let viewModel = FriendViewModel(cells: cells)
        
        viewController?.displayData(viewModel: .displayFriends(viewModel: viewModel))
    @unknown default:
        print("add new case")
    }
  }
    
    private func cellViewModel(from friend: Friend) -> FriendViewModel.Cell {
        return FriendViewModel.Cell(avatarUrlString: friend.profileImage,
                                    profileName: friend.profileName,
                                    profileSurname: friend.profileSurname,
                                    name: configureAttributedText(for: friend))
    }
    
    private func configureAttributedText(for friend: Friend) -> NSMutableAttributedString {
        let attributedText = NSMutableAttributedString(string: friend.profileName, attributes: [.font: UIFont.systemFont(ofSize: 17.0, weight: .regular)])
        attributedText.append(NSMutableAttributedString(string: " \(friend.profileSurname)", attributes: [.font: UIFont.systemFont(ofSize: 17.0, weight: .bold)]))
        return attributedText
    }
  
}
