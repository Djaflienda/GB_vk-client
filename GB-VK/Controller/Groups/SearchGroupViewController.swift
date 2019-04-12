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
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            self.tableView.delegate = self
            self.tableView.dataSource = self
        }
    }
    
    //MARK: -Properties
    
    weak var delegate: UpdateGroupInformation?
    
    //MARK: -Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        return allGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddNewGroupCell.reusableID, for: indexPath) as! AddNewGroupCell
        cell.configureCell(with: allGroups[indexPath.row])
        cell.groupButtonAction = { [unowned self] in
            self.delegate?.performAction(with: allGroups[indexPath.row])
//            allGroups[indexPath.row].isParticipating.toggle()
        }
        return cell
    }
}
