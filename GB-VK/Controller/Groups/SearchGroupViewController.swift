//
//  SearchGroupViewController.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 07/04/2019.
//  Copyright © 2019 MacBook-Игорь. All rights reserved.
//

import UIKit

protocol UpdateGroupInformation: class {
    func performAction(with group: Group)
}

class SearchGroupViewController: UIViewController {

    //MARK: -@IBOutlet
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    
    //MARK: -Properties
    
    weak var delegate: UpdateGroupInformation?
    private lazy var searchingManager = SearchingManager<Group>()
    
    //MARK: -Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Search group"
    }
    
    //MARK: -Handlers
    
}

extension SearchGroupViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48.5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        showNewGroupCreationAlert()
    }
}

extension SearchGroupViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchingManager.isSearching { return searchingManager.searchingResult.count}
        return allGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddNewGroupCell.reusableID, for: indexPath) as! AddNewGroupCell
        if searchingManager.isSearching {
            cell.configureCell(with: searchingManager.searchingResult[indexPath.row])
        } else {
            cell.configureCell(with: allGroups[indexPath.row])
            cell.groupButtonAction = { [unowned self] in
                self.delegate?.performAction(with: allGroups[indexPath.row])
            }
        }
        return cell
    }
}

extension SearchGroupViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchingManager.searchingFilter(for: searchText, in: allGroups)
        tableView.reloadData()
    }
}
