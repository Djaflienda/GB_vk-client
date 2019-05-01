//
//  FriendTableViewCell.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 07/04/2019.
//  Copyright © 2019 MacBook-Игорь. All rights reserved.
//

import UIKit

protocol FriendsCellViewModel {
    var avatarUrlString: String { get }
    var profileName: String { get }
    var profileSurname: String { get }
    var name: NSAttributedString { get }
}

class FriendCell: UITableViewCell {
    
    static let reusableID = "FriendCell"
    
    @IBOutlet private weak var shadowView: RoundShadowView!
    @IBOutlet private weak var profileNameLabel: UILabel!

    func configureCell(with data: FriendsCellViewModel) {
        self.shadowView.configureImageView(with: data.avatarUrlString)
        self.profileNameLabel.attributedText = data.name
    }
}

