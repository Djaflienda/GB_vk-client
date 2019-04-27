//
//  GroupsModels.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 27/04/2019.
//  Copyright (c) 2019 MacBook-Игорь. All rights reserved.
//

import UIKit

enum Groups {
   
  enum Model {
    struct Request {
      enum RequestType {
        case getGroupsList
      }
    }
    struct Response {
      enum ResponseType {
        case presentGroups(groups: [Group])
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case displayGroups(viewModel: GroupsViewModel)
      }
    }
  }
  
}

struct GroupsViewModel {
    struct Cell: GroupCellViewModel {
        var avatarUrlString: String
        var groupTitle: String
    }
    
    let cells: [Cell]
}
