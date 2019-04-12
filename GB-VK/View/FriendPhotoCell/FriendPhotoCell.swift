//
//  FriendPhotoCell.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 08/04/2019.
//  Copyright © 2019 MacBook-Игорь. All rights reserved.
//

import UIKit

class FriendPhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var friendPhoto: UIImageView!
    
    static let reusableID = "FriendPhotoCell"
    
    func configureCell(with data: String) {
        self.friendPhoto.image = UIImage(named: data)
    }
    
}
