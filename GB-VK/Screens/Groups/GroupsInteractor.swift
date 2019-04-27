//
//  GroupsInteractor.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 27/04/2019.
//  Copyright (c) 2019 MacBook-Игорь. All rights reserved.
//

import UIKit

protocol GroupsBusinessLogic {
  func makeRequest(request: Groups.Model.Request.RequestType)
}

class GroupsInteractor: GroupsBusinessLogic {

  var presenter: GroupsPresentationLogic?
  var service: GroupsService?
  
  func makeRequest(request: Groups.Model.Request.RequestType) {
    if service == nil {
      service = GroupsService()
    }
    switch request {
    case .getGroupsList:
        presenter?.presentData(response: .presentGroups(groups: allGroups))
    @unknown default:
        print("add new case")
    }
  }
  
}
