//
//  FriendPhotosModels.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 29/04/2019.
//  Copyright (c) 2019 MacBook-Игорь. All rights reserved.
//

import UIKit

enum FriendPhotos {
   
  enum Model {
    struct Request {
      enum RequestType {
        //@acc type for test - remove and networking manager..
        case getFriendPhotos
      }
    }
    struct Response {
      enum ResponseType {
        case presentFriendPhotos(friend: FriendsCellViewModel)
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case displayFriendPhotos(viewModel: FriendPhotoViewModel)
      }
    }
  }
}

struct FriendPhotoViewModel {
    struct Cell: FriendPhotoCellViewModel {
        var profileImage: String
    }
    var cells: [Cell]
}
