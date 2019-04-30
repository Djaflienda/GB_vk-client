//
//  FooterView.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 30/04/2019.
//  Copyright © 2019 MacBook-Игорь. All rights reserved.
//

import UIKit

class FooterView: UIView {
    
    private var postCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var loader: UIActivityIndicatorView = {
       let loader = UIActivityIndicatorView()
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.color = .white
        loader.hidesWhenStopped = true
        return loader
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(postCountLabel)
        addSubview(loader)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            
            postCountLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            postCountLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            postCountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            loader.centerXAnchor.constraint(equalTo: centerXAnchor),
            loader.topAnchor.constraint(equalTo: postCountLabel.bottomAnchor, constant: 8)
            
            ])
    }
    
    func showLoader() {
        loader.startAnimating()
    }
    
    func setTitle(title: String?) {
        loader.stopAnimating()
        postCountLabel.text = title
    }
}

