//
//  GroupsPresenter.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 27/04/2019.
//  Copyright (c) 2019 MacBook-Игорь. All rights reserved.
//

import UIKit

protocol GroupsPresentationLogic {
  func presentData(response: Groups.Model.Response.ResponseType)
}

class GroupsPresenter: GroupsPresentationLogic {
  weak var viewController: GroupsDisplayLogic?
  
  func presentData(response: Groups.Model.Response.ResponseType) {
    switch response {
    case .presentGroups(let groups):
        let cells = groups.map { (group) in
            cellViewModel(from: group)
        }
        let viewModel = GroupsViewModel(cells: cells)
        viewController?.displayData(viewModel: .displayGroups(viewModel: viewModel))
    @unknown default:
        print("add new case")
    }
  }
    
    private func cellViewModel(from group: Group) -> GroupsViewModel.Cell {
        return GroupsViewModel.Cell(avatarUrlString: group.groupImage,
                                    groupTitle: group.groupName)
    }
  
}
