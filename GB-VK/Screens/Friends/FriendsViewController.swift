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
    private var friendsViewModel = FriendViewModel()
    private var alphabeticallySorted = true
  
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

    // MARK: View lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        tableView.register(UINib(nibName: "FriendCell", bundle: nil), forCellReuseIdentifier: FriendCell.reusableID)
        interactor?.makeRequest(request: .getFriendsList(alphabeticallySorted: alphabeticallySorted))
    }
  
    func displayData(viewModel: Friends.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .displayFriends(let viewModel):
            self.friendsViewModel = viewModel
            tableView.reloadData()
        }
    }
    
    @IBAction func sortFriends(_ sender: UIBarButtonItem) {
        alphabeticallySorted.toggle()
        interactor?.makeRequest(request: .getFriendsList(alphabeticallySorted: alphabeticallySorted))
    }
}

extension FriendsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        router?.routeToFriendPhotos(segue: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
}

extension FriendsViewController: UITableViewDataSource {
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        if !friendsViewModel.cells.isEmpty { return nil }
        return friendsViewModel.friendsSectionTitles
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if !friendsViewModel.cells.isEmpty { return nil }
        return friendsViewModel.friendsSectionTitles[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if !friendsViewModel.cells.isEmpty { return 1 }
        return friendsViewModel.friendsSectionTitles.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !friendsViewModel.cells.isEmpty { return friendsViewModel.cells.count }
        let friendKey = friendsViewModel.friendsSectionTitles[section]
        if let friendValues = friendsViewModel.friendsDictionary[friendKey] {
            return friendValues.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendCell.reusableID, for: indexPath) as! FriendCell
        if friendsViewModel.cells.isEmpty {
            let friendKey = friendsViewModel.friendsSectionTitles[indexPath.section]
            if let friendValues = friendsViewModel.friendsDictionary[friendKey] {
                cell.configureCell(with: friendValues[indexPath.row])
            }
        } else {
            cell.configureCell(with: friendsViewModel.cells[indexPath.row])
        }
        return cell
    }
}

extension FriendsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchText.isEmpty ?
            interactor?.makeRequest(request: .getFriendsList(alphabeticallySorted: alphabeticallySorted)) :
            interactor?.makeRequest(request: .getFriendsListFiltered(searchText: searchText, target: friends))
    }
}
