//
//  FooterView.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 30/04/2019.
//  Copyright © 2019 MacBook-Игорь. All rights reserved.
//

import UIKit

class FooterViewWLoader: FooterView {
    
    private var loader: UIActivityIndicatorView = {
       let loader = UIActivityIndicatorView()
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.color = .white
        loader.hidesWhenStopped = true
        return loader
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(loader)

        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: centerXAnchor),
            loader.topAnchor.constraint(equalTo: postCountLabel.bottomAnchor, constant: 8)
            ])
    }
    
    func showLoader() {
        loader.startAnimating()
    }
    
    override func setTitle(title: String?) {
        super.setTitle(title: title)
        loader.stopAnimating()
    }
}

