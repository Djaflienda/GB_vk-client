//
//  AddNewGroupCell.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 08/04/2019.
//  Copyright © 2019 MacBook-Игорь. All rights reserved.
//

import UIKit

class AddNewGroupCell: UITableViewCell {

    //MARK: -@IBOutlet
    
    @IBOutlet private weak var groupImage: UIImageView!
    @IBOutlet private weak var groupName: UILabel!
    @IBOutlet private weak var groupDescription: UILabel!
    @IBOutlet private weak var groupButton: UIButton!
    
    //MARK: -Properties
    
    static let reusableID = "AddNewGroupCell"
    
    //MARK: -Init
    
    //MARK: -Handlers
    
    func configureCell(with data: Group) {
        self.groupImage.image = UIImage(named: data.groupImage)
        self.groupName.text = data.groupName
        self.groupDescription.text = data.groupDescription
        configureGroupButton(dependOn: data.isParticipating)
    }
    
    private func configureGroupButton(dependOn data: Bool) {
        switch data {
        case true:
            groupButton.setTitle("✔︎", for: .normal)
            groupButton.setTitleColor(UIColor.gray, for: .normal)
            groupButton.backgroundColor = .white
        case false:
            groupButton.setTitle("✚", for: .normal)
            groupButton.setTitleColor(UIColor.white, for: .normal)
            groupButton.backgroundColor = UIColor(red: 113/255, green: 157/255, blue: 223/255, alpha: 1.0)
        }
    }
    
    @IBAction func addNewGroup() {
        
    }

}
