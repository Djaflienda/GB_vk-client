//
//  RoundedShadowedView.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 13/04/2019.
//  Copyright © 2019 MacBook-Игорь. All rights reserved.
//

import UIKit

class RoundShadowView: UIView {
    
    //MARK: -Properties
    
    private let containerView = UIImageView()
    
    @IBInspectable var cornerRadius: CGFloat {
        get { return containerView.layer.cornerRadius }
        set { containerView.layer.cornerRadius = newValue }
    }

    @IBInspectable var shadowColor: UIColor {
        get { return UIColor(cgColor: layer.shadowColor!) }
        set { layer.shadowColor = newValue.cgColor }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get { return layer.shadowOffset }
        set { layer.shadowOffset = newValue }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get { return layer.shadowOpacity }
        set { layer.shadowOpacity = newValue }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get { return layer.shadowRadius }
        set { layer.shadowRadius = newValue }
    }
    
    //MARK: -Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        layoutView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
//        layoutView()
    }
    
    //MARK: -Handlers
    
    override func layoutSubviews() {
        super.layoutSubviews() //is essential?
        layer.backgroundColor = UIColor.clear.cgColor
        containerView.layer.masksToBounds = true
        addSubview(containerView)
        containerView.frame = bounds
    }
    
    func configureImageView(with image: String) {
        self.containerView.image = UIImage(named: image)
    }
    
//    private func layoutView() {
//        layer.backgroundColor = UIColor.clear.cgColor
//        containerView.layer.masksToBounds = true
//        addSubview(containerView)
//        containerView.frame = bounds
//        containerView.translatesAutoresizingMaskIntoConstraints = false
//
//        containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
//        containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
//        containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
//        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
//    }
}
