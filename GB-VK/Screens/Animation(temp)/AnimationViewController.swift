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
    @IBOutlet weak var image: UIImageView!
    
    @IBAction func imageTapped(_ sender: UIButton) {
//        UIView.animate(withDuration: 0.1, animations: {
//            self.image.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
//        }) { (_) in
//            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.1, options: [], animations: {
//                self.image.transform = .identity
//            }, completion: nil)
//        }
    }
    
    @objc func tapped() {
        UIView.animate(withDuration: 0.1, animations: {
            self.image.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { (_) in
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.1, options: [], animations: {
                self.image.transform = .identity
            }, completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(tapped))
        image.addGestureRecognizer(tapGR)
        image.isUserInteractionEnabled = true
//        UIView.animate(withDuration: 0.6, delay: 0, options: [.repeat], animations: {
//            self.view1.alpha = 0.1
//        }) { (true) in
//            UIView.animate(withDuration: 0.6, delay: 0, options: [.repeat], animations: {
//                self.view2.alpha = 0.1
//            }, completion: { (true) in
//                UIView.animate(withDuration: 0.6, delay: 0, options: [.repeat], animations: {
//                    self.view3.alpha = 0.1
//                }, completion: nil)
//            })
//        }
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
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}



class LoadingIndicator: UIView {
    
    private let indicators: [UIView] = (0...2).map { _ in
        let c = UIView()
        c.backgroundColor = .gray
        return c
    }
    
    static func showIndicator() {
        
    }
    
    static func removeIndicator() {}
}
