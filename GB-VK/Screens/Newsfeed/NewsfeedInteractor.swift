//
//  NewsfeedInteractor.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 26/04/2019.
//  Copyright (c) 2019 MacBook-Игорь. All rights reserved.
//

import UIKit

protocol NewsfeedBusinessLogic {
  func makeRequest(request: Newsfeed.Model.Request.RequestType)
}

class NewsfeedInteractor: NewsfeedBusinessLogic {

  var presenter: NewsfeedPresentationLogic?
  var service: NewsfeedService?
  
  func makeRequest(request: Newsfeed.Model.Request.RequestType) {
    if service == nil {
      service = NewsfeedService()
    }
    
    switch request {
    case .getNewsfeed:
        service?.getNewsfeed(complition: { [weak self] (revealPostId, newsfeed) in
            self?.presenter?.presentData(response: .presentNewsfeed(response: newsfeed, revealPostIds: revealPostId))
        })
    case .getNewsfeedBatch:
        self.presenter?.presentData(response: .presentFooterLoader)
        service?.getNewsfeedBatch(complition: { (revealPostId, newsfeed) in
            self.presenter?.presentData(response: .presentNewsfeed(response: newsfeed, revealPostIds: revealPostId))
        })
    case .revealPostIds(let postId):
        service?.revealPostIds(forPostId: postId, complition: { [weak self] (revealPostId, newsfeed) in
            self?.presenter?.presentData(response: .presentNewsfeed(response: newsfeed, revealPostIds: revealPostId))
        })
    }
  }
}
