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
        case getNewsfeedBatch
        case revealPostIds(postId: Int) //expand post textView if "Show more" button tapped
      }
    }
    
    struct Response {
      enum ResponseType {
        case presentNewsfeed(response: NewsfeedResponse, revealPostIds: [Int])
        case presentFooterLoader
      }
    }
    
    struct ViewModel {
      enum ViewModelData {
        case displayNewsfeed(viewModel: NewsfeedViewModel)
        case displayFooterLoader
      }
    }
    
  }
}

struct NewsfeedViewModel {
    struct Cell: NewsfeedCellViewModel {
        var postId: Int
        var avatarUrlString: String
        var title: String
        var date: String
        var body: String?
        var likes: String?
        var comments: String?
        var shares: String?
        var views: String?
        var photoAttachment: NewsfeedCellPhotoAttachmentViewModel?
        var sizes: NewsfeedCellSizes
    }
    
    struct FeedCellPhotoAttachment: NewsfeedCellPhotoAttachmentViewModel {
        var photoUrlString: String?
        var width: Int
        var height: Int
    }
    
    let cells: [Cell]
    let footerTitle: String?
}
