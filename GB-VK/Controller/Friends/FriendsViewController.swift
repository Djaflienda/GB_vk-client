//
//  FriendsViewController.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 07/04/2019.
//  Copyright © 2019 MacBook-Игорь. All rights reserved.
//

import UIKit

class FriendsViewController: UIViewController {

    //MARK: -@IBOutlet
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            self.tableView.delegate = self
            self.tableView.dataSource = self
        }
    }
    
    //MARK: -Properties
    
    private var friendsDictionary = [String: [Friend]]()
    private var friendsSectionTitles = [String]()
    
    //MARK: -Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        friends.forEach { (friend) in
            let sectionKey = String(friend.profileSurname.prefix(1))
            if let _ = friendsDictionary[sectionKey] {
                friendsDictionary[sectionKey]?.append(friend)
            } else {
                friendsDictionary.updateValue([friend], forKey: sectionKey)
            }
        }
        friendsSectionTitles.append(contentsOf: friendsDictionary.keys.sorted(by: <))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Friends"
    }
    
    //MARK: -Handlers
    
}

extension FriendsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48.5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "FriendPhotosViewController") as! FriendPhotosViewController
        let key = friendsSectionTitles[indexPath.section]
        destinationVC.friendName = friendsDictionary[key]?[indexPath.row].profileName
        destinationVC.friendImageName = friendsDictionary[key]?[indexPath.row].profileImage
        navigationController?.pushViewController(destinationVC, animated: true)
    }
}

extension FriendsViewController: UITableViewDataSource {
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return friendsSectionTitles
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return friendsSectionTitles[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return friendsSectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let friendKey = friendsSectionTitles[section]
        if let friendValues = friendsDictionary[friendKey] {
            return friendValues.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendTableViewCell.reusableID,
                                                 for: indexPath) as! FriendTableViewCell
        let friendKey = friendsSectionTitles[indexPath.section]
        if let friendValues = friendsDictionary[friendKey] {
            cell.configureCell(with: friendValues[indexPath.row])
        }
        return cell
    }
}
