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

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!
    
    var interactor: FriendsBusinessLogic?
    var router: (NSObjectProtocol & FriendsRoutingLogic & FriendsDataPassing)?
    var friendsViewModel = FriendViewModel()
    var alphabeticallySorted = true
    private var footerView = FooterView(textColor: .darkGray)
  
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
        router.dataStore          = interactor
    }

    // MARK: View lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        tableView.register(UINib(nibName: "FriendCell", bundle: nil), forCellReuseIdentifier: FriendCell.reusableID)
        tableView.tableFooterView = footerView
//        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
//        view.addGestureRecognizer(hideKeyboardGesture)
        interactor?.makeRequest(request: .getFriendsList(alphabeticallySorted: alphabeticallySorted))
    }
  
    func displayData(viewModel: Friends.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .displayFriends(let viewModel):
            self.friendsViewModel = viewModel
            tableView.reloadData()
            footerView.setTitle(title: String(friends.count) + " friends")
        }
    }
    
    @IBAction func sortFriends(_ sender: UIBarButtonItem) {
        alphabeticallySorted.toggle()
        interactor?.makeRequest(request: .getFriendsList(alphabeticallySorted: alphabeticallySorted))
    }
    
//    @objc private func hideKeyboard() {
//        view.endEditing(true)
//    }
}
