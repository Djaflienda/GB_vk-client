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
    
    @IBOutlet private weak var tableView: UITableView!
    
    //MARK: -Properties
    
    private let friendsArray = [
        Friend(profileImage: "friend0", profileName: "Slawomira Pelikan"),
        Friend(profileImage: "friend1", profileName: "Nuria Pelayo"),
        Friend(profileImage: "friend2", profileName: "Gladys Kanyinda"),
        Friend(profileImage: "friend3", profileName: "Gaspar Antunes"),
        Friend(profileImage: "friend4", profileName: "Song Bao")
    ]
    
    //MARK: -Init
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        title = "Friends"
    }
    
    //MARK: -Handlers
    
}

extension FriendsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "FriendPhotosViewController") as! FriendPhotosViewController
        navigationController?.pushViewController(destinationVC, animated: true)
    }
}

extension FriendsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! FriendTableViewCell
        cell.configureCell(with: friendsArray[indexPath.row])
        return cell
    }
}
