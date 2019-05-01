//
//  FriendsWorker.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 26/04/2019.
//  Copyright (c) 2019 MacBook-Игорь. All rights reserved.
//

import UIKit

class FriendsService {
    
    
    //<<<REFACTOR THIS CODE LATER>>>
    
    func getFriendsList(_ data: (friends: [Friend], alphabeticallySorted: Bool)) -> FriendViewModel {
        var viewModel = FriendViewModel()
        switch data.alphabeticallySorted {
        case true:
            data.friends.forEach { (friend) in
                let sectionKey = String(friend.profileSurname.prefix(1))
                if let _ = viewModel.friendsDictionary[sectionKey] {
                    viewModel.friendsDictionary[sectionKey]?.append(cellViewModel(from: friend))
                } else {
                    viewModel.friendsDictionary.updateValue([cellViewModel(from: friend)], forKey: sectionKey)
                }
            }
            viewModel.friendsSectionTitles.append(contentsOf: viewModel.friendsDictionary.keys.sorted(by: <))
        case false:
            let cells = data.friends.map {cellViewModel(from: $0)}
            viewModel.cells = cells
        }
        return viewModel
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
