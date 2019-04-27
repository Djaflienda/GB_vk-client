//
//  GroupCell.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 27/04/2019.
//  Copyright © 2019 MacBook-Игорь. All rights reserved.
//

import UIKit

protocol GroupCellViewModel {
    var avatarUrlString: String { get }
    var groupTitle: String { get }
}

class GroupCell: UITableViewCell {

    static let reuseID = "GroupCell"
    
    @IBOutlet weak var groupImage: UIImageView!
    @IBOutlet weak var groupTitleLabel: UILabel!
    
    func configureCell(with data: GroupCellViewModel) {
        self.groupImage.image = UIImage(named: data.avatarUrlString)
        self.groupTitleLabel.text = data.groupTitle
    }
    
}
