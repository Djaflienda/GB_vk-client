//
//  NewsfeedModels.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 26/04/2019.
//  Copyright (c) 2019 MacBook-Игорь. All rights reserved.
//

import UIKit

//Newsfeed -> Model -> (Request, Response, ViewModel)

enum Newsfeed {
   
  enum Model {
    
    struct Request {
      enum RequestType {
        case getNewsfeed
      }
    }
    
    struct Response {
      enum ResponseType {
        case presentNewsfeed(response: NewsfeedResponse)
      }
    }
    
    struct ViewModel {
      enum ViewModelData {
        case displayNewsfeed(viewModel: NewsfeedViewModel)
      }
    }
    
  }
}

struct NewsfeedViewModel {
    struct Cell: NewsfeedCellViewModel {
        var avatarUrlString: String
        var title: String
        var date: String
        var body: String?
        var likes: String?
        var comments: String?
        var shares: String?
        var views: String?
        var photoAttachment: NewsfeedCellPhotoAttachmentViewModel?
    }
    
    struct FeedCellPhotoAttachment: NewsfeedCellPhotoAttachmentViewModel {
        var photoUrlString: String?
        var width: Int
        var height: Int
    }
    
    let cells: [Cell]
}
