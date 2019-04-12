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

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            self.tableView.delegate = self
            self.tableView.dataSource = self
        }
    }
    
    //MARK: -Properties
    
    private var groupsArray: [Group] = {
        allGroups.filter {$0.isParticipating}
    }()
    
    //MARK: -Init
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Groups"
    }
    
    //MARK: -Handlers
    
    private func toggleIsParticipatingProperty(for group: Group) {
        guard let indexOfElement = allGroups.firstIndex(where: {$0 == group}) else {return}
        allGroups[indexOfElement].isParticipating.toggle()
    }

    @IBAction func addNewGroupButtonPressed(_ sender: UIBarButtonItem) {
        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "SearchGroupViewController") as! SearchGroupViewController
        destinationVC.delegate = self
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    @IBAction func createNewGroupButtonPressed(_ sender: UIBarButtonItem) {
        showNewGroupCreationAlert()
    }
}

extension GroupsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48.5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        showNewGroupCreationAlert()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            toggleIsParticipatingProperty(for: groupsArray[indexPath.row])
            groupsArray.remove(at: indexPath.row)
            let indexPath = IndexPath(row: indexPath.row, section: 0)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension GroupsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GroupCell.reusableID,
                                                 for: indexPath) as! GroupCell
        cell.configureCell(with: groupsArray[indexPath.row])
        return cell
    }
}

extension GroupsViewController: UpdateGroupInformation {
    
    func performAction(with group: Group) {
        switch groupsArray.contains(group) {
        case true:
            let indexOfElement = groupsArray.firstIndex(where: {$0 == group})
            groupsArray.remove(at: indexOfElement!)
        case false:
            groupsArray.insert(group, at: 0)
            groupsArray[0].isParticipating.toggle()
        }
        toggleIsParticipatingProperty(for: group)
        tableView.reloadData()
    }
}
