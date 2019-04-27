//
//  GroupsViewController.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 07/04/2019.
//  Copyright © 2019 MacBook-Игорь. All rights reserved.
//
//
//import UIKit
//
//class GroupsViewController1: UIViewController {
//    
//    private var groupsArray: [Group] = {
//        allGroups.filter {$0.isParticipating}
//    }()
//
//    private func toggleIsParticipatingProperty(for group: Group) {
//        guard let indexOfElement = allGroups.firstIndex(where: {$0 == group}) else {return}
//        allGroups[indexOfElement].isParticipating.toggle()
//    }
//
//    @IBAction func addNewGroupButtonPressed(_ sender: UIBarButtonItem) {
//        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "SearchGroupViewController") as! SearchGroupViewController
//        destinationVC.delegate = self
//        navigationController?.pushViewController(destinationVC, animated: true)
//    }
//    
//    @IBAction func createNewGroupButtonPressed(_ sender: UIBarButtonItem) {
//        showNewGroupCreationAlert()
//    }
//}
//
//extension GroupsViewController1: UpdateGroupInformation {
//    
//    func performAction(with group: Group) {
//        switch groupsArray.contains(group) {
//        case true:
//            let indexOfElement = groupsArray.firstIndex(where: {$0 == group})
//            groupsArray.remove(at: indexOfElement!)
//        case false:
//            groupsArray.insert(group, at: 0)
//            groupsArray[0].isParticipating.toggle()
//        }
//        toggleIsParticipatingProperty(for: group)
//        tableView.reloadData()
//    }
//}
