//
//  NewsfeedCodeCell.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 29/04/2019.
//  Copyright © 2019 MacBook-Игорь. All rights reserved.
//

import UIKit

protocol NewsfeedCodeCellDelegate: class {
    func revealPost(for cell: NewsfeedCodeCell)
}

final class NewsfeedCodeCell: UITableViewCell {
    
    static let reuseID = "NewsfeedCodeCell"
    
    weak var delegate: NewsfeedCodeCellDelegate?
    
    let cardView: UIView = {
        let cv = UIView()
        cv.backgroundColor = .white
        cv.layer.cornerRadius = 8
        cv.clipsToBounds = true
        return cv
    }()
    
    let topView = NewsfeedCellTopView()
    
    let bodyLabel: UITextView = {
        let label = UITextView()
        label.font = UIFont.systemFont(ofSize: 15)
        label.isScrollEnabled = false
        label.isSelectable = true
        label.isUserInteractionEnabled = true
        label.isEditable = false
        let padding = label.textContainer.lineFragmentPadding
        label.textContainerInset = UIEdgeInsets(top: 0, left: -padding, bottom: 0, right: -padding)
        label.dataDetectorTypes = UIDataDetectorTypes.all
        return label
    }()
    
    let  moreTextButton: UIButton = {
        let mtb = UIButton()
        mtb.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        mtb.setTitleColor(#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1), for: .normal)
        mtb.contentHorizontalAlignment = .left
        mtb.contentVerticalAlignment = .center
        mtb.setTitle("Show more", for: .normal)
        return mtb
    }()
    
    let postImageView = WebImageView()
    let bottomView = NewsfeedCellBottomView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.selectionStyle = .none
        moreTextButton.addTarget(self, action: #selector(moreTextButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func moreTextButtonTapped() {
        delegate?.revealPost(for: self)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        topView.prepareForReuse()
        postImageView.set(imageURL: nil)
    }
    
    func configure(with data: NewsfeedCellViewModel) {
        topView.configure(with: data)
        bodyLabel.text = data.body
        bodyLabel.frame = data.sizes.bodyLableFrame
        moreTextButton.frame = data.sizes.moreTextButtonFrame
        postImageView.frame = data.sizes.postImageViewFrame
        bottomView.frame = data.sizes.bottomView
        bottomView.configure(with: data)
        
        if let photoAttachment = data.photoAttachment {
            postImageView.set(imageURL: photoAttachment.photoUrlString)
            postImageView.isHidden = false
        } else {
            postImageView.isHidden = true
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(cardView)
        cardView.addSubviews(views: [topView, bodyLabel, moreTextButton, postImageView, bottomView])
        
        cardView.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: bottomAnchor, padding: .init(top: 4, left: 2, bottom: 4, right: 2))
        topView.anchor(top: cardView.topAnchor, leading: cardView.leadingAnchor, trailing: cardView.trailingAnchor, size: .init(width: 0, height: 56))
    }
}
