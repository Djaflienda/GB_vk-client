//
//  FriendPhotoCell.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 29/04/2019.
//  Copyright © 2019 MacBook-Игорь. All rights reserved.
//

import UIKit

protocol FriendPhotoCellViewModel {
    var profileImage: String { get }
}

class FriendPhotoCell: UICollectionViewCell {
    
    static let reuseID = "FriendPhotoCell"
    
    @IBOutlet private weak var friendPhoto: UIImageView!
    
    func configure(with data: FriendPhotoCellViewModel) {
        self.friendPhoto.image = UIImage(named: data.profileImage)
    }
}
