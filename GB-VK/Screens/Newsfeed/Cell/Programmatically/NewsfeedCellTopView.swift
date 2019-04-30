//
//  NewsfeedCellTopView.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 30/04/2019.
//  Copyright © 2019 MacBook-Игорь. All rights reserved.
//

import UIKit

final class NewsfeedCellTopView: UIView {
    
    private let avatarImage: WebImageView = {
        let nfa = WebImageView()
        nfa.layer.cornerRadius = 20
        nfa.clipsToBounds = true
        return nfa
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0, green: 0.3124817436, blue: 0.5585669949, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.5768421292, green: 0.6187390685, blue: 0.664434731, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addSubviews(views: [avatarImage, titleLabel, dateLabel])
        
        avatarImage.anchor(top: topAnchor, leading: leadingAnchor, padding: .init(top: 8, left: 8, bottom: 0, right: 0), size: .init(width: 40, height: 40))
        titleLabel.anchor(top: topAnchor, leading: avatarImage.trailingAnchor, trailing: trailingAnchor, padding: .init(top: 8, left: 8, bottom: 0, right: 8), size: .init(width: 0, height: 20))
        dateLabel.anchor(top: titleLabel.bottomAnchor, leading: avatarImage.trailingAnchor, trailing: trailingAnchor, padding: .init(top: 4, left: 8, bottom: 0, right: 8), size: .init(width: 0, height: 13))
    }
    
    func configure(with data: NewsfeedCellViewModel) {
        avatarImage.set(imageURL: data.avatarUrlString)
        titleLabel.text = data.title
        dateLabel.text = data.date
    }
    
    func prepareForReuse() {
        avatarImage.set(imageURL: nil)
    }
}
