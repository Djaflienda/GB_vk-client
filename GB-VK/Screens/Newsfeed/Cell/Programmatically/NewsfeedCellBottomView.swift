//
//  NewsfeedCellBottomView.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 30/04/2019.
//  Copyright © 2019 MacBook-Игорь. All rights reserved.
//

import UIKit

final class NewsfeedCellBottomView: UIView {
    
    private var stackView: UIStackView = {
        let sv = UIStackView()
        sv.distribution = .fillEqually
        return sv
    }()
    
    //0. - likes; 1. - comments; 2. - shares; 3. - views
    private let views = (0...3).map { _ in UIView()}
    
    private let images = ["like", "comment", "share", "eye"].map { UIImageView(image: UIImage(named: $0)) }
    
    private let labels = (0...3).map { _ -> UILabel in
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.5768421292, green: 0.6187390685, blue: 0.664434731, alpha: 1)
        return label
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addSubview(stackView)
        stackView.addArrangedSubviews(views: views)
        (0...3).forEach { views[$0].addSubviews(views: [images[$0], labels[$0]])}
        
        stackView.anchor(leading: leadingAnchor, trailing: trailingAnchor, size: .init(width: 0, height: 40))

        (0...3).forEach {
            images[$0].anchor(top: views[$0].topAnchor, leading: views[$0].leadingAnchor, padding: .init(top: 8, left: 10, bottom: 0, right: 0), size: .init(width: 25, height: 25))
            labels[$0].anchor(top: images[$0].topAnchor, leading: images[$0].trailingAnchor, trailing: views[$0].trailingAnchor, padding: .init(top: 0, left: 4, bottom: 0, right: 8), size: .init(width: 0, height: 25))
        }
    }
    
    func configure(with data: NewsfeedCellViewModel) {
        labels[0].text = data.likes
        labels[1].text = data.comments
        labels[2].text = data.shares
        labels[3].text = data.views
    }
}
