//
//  CustomControl.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 14/04/2019.
//  Copyright © 2019 MacBook-Игорь. All rights reserved.
//

import UIKit

class CustomControl: UIControl {
    
    var isLiked: Bool = false
    var stackView: UIStackView!
    let likeView = UIImageView(image: UIImage(named: "heart-empty"))
    let likeLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    private func setupView() {
        
        self.stackView = UIStackView(arrangedSubviews: [likeLabel, likeView])
        self.stackView.axis = .horizontal
        self.likeLabel.text = "0"
        self.likeLabel.textAlignment = .right
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(likeTapped))
        self.addGestureRecognizer(tapGR)
//        OR
//        likeView.isUserInteractionEnabled = true
//        likeView.addGestureRecognizer(tapGR)
    }
    
    @objc func likeTapped() {
        isLiked.toggle()
        
        UIView.transition(with: self.likeLabel, duration: 0.15, options: .transitionFlipFromRight, animations: { self.likeLabel.text = self.isLiked ? "1" : "0" }, completion: { _ in
            UIView.transition(with: self.likeView, duration: 0.3, options: .transitionFlipFromTop, animations: {
                self.likeView.image = self.isLiked ? UIImage(named: "heart-filled") : UIImage(named: "heart-empty") }, completion: nil)
        })
        self.likeLabel.textColor = self.isLiked ? .red : .black

//        UIView.transition(with: self, duration: 0.3, options: .transitionFlipFromTop, animations: {
//            self.likeView.image = self.isLiked ? UIImage(named: "heart-filled") : UIImage(named: "heart-empty")
//            self.likeLabel.text = self.isLiked ? "1" : "0"
//            self.likeLabel.textColor = self.isLiked ? .red : .black
//        }, completion: nil)
        sendActions(for: .valueChanged)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addSubview(stackView)
        self.stackView.frame = bounds
        
        likeLabel.translatesAutoresizingMaskIntoConstraints = false
        likeView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            likeView.heightAnchor.constraint(equalTo: stackView.heightAnchor),
            likeView.widthAnchor.constraint(equalTo: likeView.heightAnchor)
            ])
    }
}
