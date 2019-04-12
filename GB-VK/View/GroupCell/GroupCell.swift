//
//  GroupTableViewCell.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 07/04/2019.
//  Copyright © 2019 MacBook-Игорь. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {

    //MARK: -@IBOutlet
    
    @IBOutlet private weak var groupImage: UIImageView!
    @IBOutlet private weak var groupName: UILabel!
    @IBOutlet private weak var groupDescription: UILabel!
    
    //MARK: -Properties
    
    static let reusableID = "GroupCell"
    
    //MARK: -Init
    
    //MARK: -Handlers
    
    func configureCell(with data: Group) {
        self.groupImage.image = UIImage(named: data.groupImage)
        self.groupName.text = data.groupName
        self.groupDescription.text = data.groupDescription
    }

}
