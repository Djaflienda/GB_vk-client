//
//  FriendsViewController.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 26/04/2019.
//  Copyright (c) 2019 MacBook-Игорь. All rights reserved.
//

import UIKit

protocol FriendsDisplayLogic: class {
  func displayData(viewModel: Friends.Model.ViewModel.ViewModelData)
}

class FriendsViewController: UIViewController, FriendsDisplayLogic {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
  var interactor: FriendsBusinessLogic?
  var router: (NSObjectProtocol & FriendsRoutingLogic)?
    private var friendsViewModel = FriendViewModel(cells: [])
  
  // MARK: Setup
  
  private func setup() {
    let viewController        = self
    let interactor            = FriendsInteractor()
    let presenter             = FriendsPresenter()
    let router                = FriendsRouter()
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
    tableView.register(UINib(nibName: "FriendCell", bundle: nil), forCellReuseIdentifier: FriendCell.reusableID)
    interactor?.makeRequest(request: .getFriendsList)
  }
  
  func displayData(viewModel: Friends.Model.ViewModel.ViewModelData) {
    switch viewModel {
    case .displayFriends(let viewModel):
        self.friendsViewModel = viewModel
        tableView.reloadData()
    @unknown default:
        print("add new case")
    }
  }
}

extension FriendsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
}

extension FriendsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsViewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendCell.reusableID, for: indexPath) as! FriendCell
        cell.configureCell(with: friendsViewModel.cells[indexPath.row])
        return cell
    }
}

extension FriendsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchText.isEmpty ?
            interactor?.makeRequest(request: .getFriendsList) :
            interactor?.makeRequest(request: .getFriendsListFiltered(searchText: searchText,
                                                                     target: friends))
    }
}
