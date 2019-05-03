//
//  FriendPhotosPresenter.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 29/04/2019.
//  Copyright (c) 2019 MacBook-Игорь. All rights reserved.
//

import UIKit

protocol FriendPhotosPresentationLogic {
  func presentData(response: FriendPhotos.Model.Response.ResponseType)
}

class FriendPhotosPresenter: FriendPhotosPresentationLogic {
  weak var viewController: FriendPhotosDisplayLogic?
  
    func presentData(response: FriendPhotos.Model.Response.ResponseType) {
        switch response {
        case .presentFriendPhotos(let friend):
            let viewModel = cellViewModel(from: friend)
            viewController?.displayData(viewModel: .displayFriendPhotos(viewModel: viewModel))
        }
    }
    
    private func cellViewModel(from friend: Friend) -> FriendPhotoViewModel {
        return FriendPhotoViewModel(userID: friend.userID, avatarUrlString: friend.profileImage, profileName: friend.profileName, avatarUrlStrings: /*friend.profileImages*/friendPhotos)
    }
  
}
