//
//  AnimationViewController.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 27/04/2019.
//  Copyright © 2019 MacBook-Игорь. All rights reserved.
//

import UIKit

class AnimationViewController: UIViewController {

    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.6, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.view1.alpha = 0.1
            self.view1.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        })
        UIView.animate(withDuration: 0.6, delay: 0.3, options: [.repeat, .autoreverse], animations: {
            self.view2.alpha = 0.1
            self.view2.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)

        })
        UIView.animate(withDuration: 0.6, delay: 0.6, options: [.repeat, .autoreverse], animations: {
            self.view3.alpha = 0.1
            self.view3.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)

        })
    }
}

extension AnimationViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(collectionView.cellForItem(at: indexPath)?.frame)
        print(collectionView.frame)
    }
}

class TestCVCell: UICollectionViewCell {
    
    static let reuseID = "TestCVCell"
    @IBOutlet weak var image: UIImageView!
    
    func configure(image: String) {
        self.image.image = UIImage(named: image)
    }
}

extension AnimationViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friendPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TestCVCell.reuseID, for: indexPath) as! TestCVCell
        cell.configure(image: friendPhotos[indexPath.row])
        
        return cell
    }
}

extension AnimationViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 3 - 8
        return CGSize(width: width, height: width)
    }
}

