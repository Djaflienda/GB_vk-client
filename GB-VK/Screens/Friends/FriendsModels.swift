//
//  FriendsModels.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 26/04/2019.
//  Copyright (c) 2019 MacBook-Игорь. All rights reserved.
//

import UIKit

enum Friends {
   
  enum Model {
    struct Request {
      enum RequestType {
        case getFriendsList
        case getFriendsListFiltered(searchText: String, target: [Friend])
      }
    }
    struct Response {
      enum ResponseType {
        case presentFrieds(friends: [Friend])
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case displayFriends(viewModel: FriendViewModel)
      }
    }
  }
  
}

struct FriendViewModel {
    struct Cell: FriendsCellViewModel {
        var avatarUrlString: String
        var profileName: String
        var profileSurname: String
        var name: NSAttributedString
    }
    
    let cells: [Cell]
}
