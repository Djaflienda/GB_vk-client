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
    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkManager())
  
  func makeRequest(request: Newsfeed.Model.Request.RequestType) {
    if service == nil {
      service = NewsfeedService()
    }
    
    switch request {
    case .getNewsfeed:
        print(".getNewsfeed Interactor")
        fetcher.getNewsfeed { [weak self] (response) in
            guard let newsfeedResponse = response else { return }
            self?.presenter?.presentData(response: .presentNewsfeed(response: newsfeedResponse))
        }
    @unknown default:
        print("add new case")

    }
  }
  
}
