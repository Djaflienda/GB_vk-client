//
//  extTableViewSetup.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 01/05/2019.
//  Copyright © 2019 MacBook-Игорь. All rights reserved.
//

import UIKit

extension FriendsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if !friendsViewModel.cells.isEmpty {
            let userID = friendsViewModel.cells[indexPath.row].userID
            interactor?.prepareDataPassing(for: userID)
        } else {
            let section = friendsViewModel.friendsSectionTitles[indexPath.section]
            guard let userID = friendsViewModel.friendsDictionary[section]?[indexPath.row].userID else { return }
            interactor?.prepareDataPassing(for: userID)
        }
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
