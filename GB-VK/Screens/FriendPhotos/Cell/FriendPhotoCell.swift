//
//  FriendPhotoCell.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 29/04/2019.
//  Copyright © 2019 MacBook-Игорь. All rights reserved.
//

import UIKit

protocol FriendPhotoCellViewModel {
    var userID: Int { get }
    var avatarUrlString: String { get }
    var profileName: String { get }
    var avatarUrlStrings: [String] { get }
}

class FriendPhotoCell: UICollectionViewCell {
    
    static let reuseID = "FriendPhotoCell"
    
    @IBOutlet private weak var friendPhoto: UIImageView!
    
    func configure(with data: FriendPhotoCellViewModel, at index: Int) {
        self.friendPhoto.image = UIImage(named: data.avatarUrlStrings[index])
//        self.friendPhoto.tag = index
//        let tapGR = UITapGestureRecognizer(target: self, action: #selector(tapped))
//        friendPhoto.addGestureRecognizer(tapGR)
        friendPhoto.isUserInteractionEnabled = true
    }
    
    @objc func tapped(sender: UITapGestureRecognizer) {
//        print(self.center)
//        print(sender.view?.tag)
        UIView.animate(withDuration: 0.1, animations: {
            self.friendPhoto.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { (_) in
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.1, options: [], animations: {
                self.friendPhoto.transform = .identity
            }, completion: nil)
        }
    }
}
