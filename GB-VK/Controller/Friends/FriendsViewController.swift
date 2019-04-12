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
    
    private let friendsArray = /*[Friend]()*/ friends
    
    //MARK: -Init
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        destinationVC.friendName = friendsArray[indexPath.row].profileName
        destinationVC.friendImageName = friendsArray[indexPath.row].profileImage
        navigationController?.pushViewController(destinationVC, animated: true)
    }
}

extension FriendsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendTableViewCell.reusableID,
                                                 for: indexPath) as! FriendTableViewCell
        cell.configureCell(with: friendsArray[indexPath.row])
        return cell
    }
}
