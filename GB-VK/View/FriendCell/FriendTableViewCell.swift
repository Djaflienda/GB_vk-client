//
//  FriendTableViewCell.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 07/04/2019.
//  Copyright © 2019 MacBook-Игорь. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var profileImage: UIImageView!
    @IBOutlet private weak var profileNameLabel: UILabel!

    func configureCell(with data: Friend) {
        self.profileImage.image = UIImage(named: data.profileImage)
        self.profileNameLabel.text = data.profileName
    }
}
