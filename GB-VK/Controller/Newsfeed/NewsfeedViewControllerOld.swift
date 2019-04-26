//
//  NewsfeedViewController.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 25/04/2019.
//  Copyright © 2019 MacBook-Игорь. All rights reserved.
//

import UIKit

class NewsfeedViewControllerOld: UIViewController {

    //MARK: -IBOutlet
    @IBOutlet private weak var tableView: UITableView!
    
    //MARK: -Properties
    
    //MARK: -Init
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    //MARK: -Handlers
}

extension NewsfeedViewControllerOld: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 212.0
    }
}

extension NewsfeedViewControllerOld: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsfeedTableViewCell.reuseID, for: indexPath) as! NewsfeedTableViewCell
        
        
        return cell
    }
}
