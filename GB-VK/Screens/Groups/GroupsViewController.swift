//
//  GroupsViewController.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 27/04/2019.
//  Copyright (c) 2019 MacBook-Игорь. All rights reserved.
//

import UIKit

protocol GroupsDisplayLogic: class {
  func displayData(viewModel: Groups.Model.ViewModel.ViewModelData)
}

class GroupsViewController: UIViewController, GroupsDisplayLogic {

    @IBOutlet weak var tableView: UITableView!
    
  var interactor: GroupsBusinessLogic?
  var router: (NSObjectProtocol & GroupsRoutingLogic)?
    private var groupsViewModel = GroupsViewModel(cells: [])

  
  // MARK: Setup
  
  private func setup() {
    let viewController        = self
    let interactor            = GroupsInteractor()
    let presenter             = GroupsPresenter()
    let router                = GroupsRouter()
    viewController.interactor = interactor
    viewController.router     = router
    interactor.presenter      = presenter
    presenter.viewController  = viewController
    router.viewController     = viewController
  }
  
  // MARK: Routing
  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    tableView.register(UINib(nibName: "GroupCell", bundle: nil), forCellReuseIdentifier: GroupCell.reuseID)
    interactor?.makeRequest(request: .getGroupsList)
  }
  
  func displayData(viewModel: Groups.Model.ViewModel.ViewModelData) {
    switch viewModel {
    case .displayGroups(let viewModel):
        self.groupsViewModel = viewModel
        tableView.reloadData()
    @unknown default:
        print("add new case")
    }
  }
}

extension GroupsViewController: UITableViewDelegate {}

extension GroupsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GroupCell.reuseID, for: indexPath) as! GroupCell
        cell.configureCell(with: groupsViewModel.cells[indexPath.row])
        return cell
    }
}
