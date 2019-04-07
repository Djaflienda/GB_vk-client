//
//  GroupsViewController.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 07/04/2019.
//  Copyright © 2019 MacBook-Игорь. All rights reserved.
//

import UIKit

class GroupsViewController: UIViewController {
    
    //MARK: -@IBOutlet

    @IBOutlet private weak var tableView: UITableView!
    
    //MARK: -Properties
    
    private var groupsArray = [String]()
    
    //MARK: -Init
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        title = "Groups"
    }
    
    //MARK: -Handlers

    @IBAction func searchGroupButtonPressed(_ sender: UIBarButtonItem) {
        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "SearchGroupViewController") as! SearchGroupViewController
        navigationController?.pushViewController(destinationVC, animated: true)
    }
}

extension GroupsViewController: UITableViewDelegate {}

extension GroupsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath)
        
        //configure cell
        
        return cell
    }
}
