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
            let cell = cellViewModel(from: friend)
            let viewModel = FriendPhotoViewModel(cells: [cell])
            viewController?.displayData(viewModel: .displayFriendPhotos(viewModel: viewModel))
        @unknown default:
            print("add new case")
        }
    }
    
    private func cellViewModel(from friend: FriendsCellViewModel) -> FriendPhotoViewModel.Cell {
        return FriendPhotoViewModel.Cell(profileImage: friend.avatarUrlString)
    }
  
}
