//
//  FooterView1.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 01/05/2019.
//  Copyright © 2019 MacBook-Игорь. All rights reserved.
//

import UIKit

class FooterView: UIView {
    
    var postCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    convenience init(textColor: UIColor) {
        self.init()
        postCountLabel.textColor = textColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(postCountLabel)
        
        postCountLabel.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, padding: .init(top: 8, left: 20, bottom: 0, right: 20))
    }
    
    func setTitle(title: String?) {
        postCountLabel.text = title
    }
}

