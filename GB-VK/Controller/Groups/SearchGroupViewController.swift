//
//  SearchGroupViewController.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 07/04/2019.
//  Copyright © 2019 MacBook-Игорь. All rights reserved.
//

import UIKit

class SearchGroupViewController: UIViewController {

    //MARK: -@IBOutlet
    
    @IBOutlet private weak var tableView: UITableView!
    
    //MARK: -Properties
    
    private var groupsArray = [String]()
    
    //MARK: -Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        title = "Search group"
    }
    
    //MARK: -Handlers
    
}

extension SearchGroupViewController: UITableViewDelegate {}

extension SearchGroupViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SGroupCell", for: indexPath)
        
        //configure cell
        
        return cell
    }
}
