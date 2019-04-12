//
//  FriendTableViewCell.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 07/04/2019.
//  Copyright © 2019 MacBook-Игорь. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {
    
    static let reusableID = "FriendTableViewCell"
    
    @IBOutlet private weak var profileImage: UIImageView!
    @IBOutlet private weak var profileNameLabel: UILabel!

    func configureCell(with data: Friend) {
        self.profileImage.image = UIImage(named: data.profileImage)
        
        let attributedText = NSMutableAttributedString(string: data.profileName, attributes: [.font: UIFont.systemFont(ofSize: 17.0, weight: .regular)])
        attributedText.append(NSMutableAttributedString(string: " \(data.profileSurname)", attributes: [.font: UIFont.systemFont(ofSize: 17.0, weight: .bold)]))
        
        self.profileNameLabel.attributedText = attributedText
    }
}
