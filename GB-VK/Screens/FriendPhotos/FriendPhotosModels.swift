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
        case getFriendPhotos
      }
    }
    struct Response {
      enum ResponseType {
        case presentFriendPhotos(friend: Friend)
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case displayFriendPhotos(viewModel: FriendPhotoViewModel)
      }
    }
  }
}

struct FriendPhotoViewModel: FriendPhotoCellViewModel {
    var userID: Int
    var avatarUrlString: String
    var profileName: String
    var avatarUrlStrings: [String]
}
