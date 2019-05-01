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
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: -Handlers
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.backgroundColor = UIColor.clear.cgColor
        addSubview(containerView)
        containerView.frame = bounds
        containerView.layer.masksToBounds = true
    }
    
    func configureImageView(with image: String) {
        self.containerView.image = UIImage(named: image)
    }
}
