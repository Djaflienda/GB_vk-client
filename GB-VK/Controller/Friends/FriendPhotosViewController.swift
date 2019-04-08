//
//  FriendPhotosViewController.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 07/04/2019.
//  Copyright © 2019 MacBook-Игорь. All rights reserved.
//

import UIKit

class FriendPhotosViewController: UIViewController {

    //MARK: -@IBOutlet
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    //MARK: -Properties

    var friendName: String!
    var friendImageName: String!
    
    //MARK: -Init
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = friendName
    }
    
    //MARK: -Handlers

}

extension FriendPhotosViewController: UICollectionViewDelegate {}

extension FriendPhotosViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FriendPhotoCell.reusableID, for: indexPath) as! FriendPhotoCell
        cell.configureCell(with: friendImageName)
        return cell
    }
}

extension FriendPhotosViewController: UICollectionViewDelegateFlowLayout {}
