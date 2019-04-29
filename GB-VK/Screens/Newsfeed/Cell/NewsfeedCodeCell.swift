//
//  NewsfeedCodeCell.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 29/04/2019.
//  Copyright © 2019 MacBook-Игорь. All rights reserved.
//

import UIKit

final class NewsfeedCodeCell: UITableViewCell {
    
    static let reuseID = "NewsfeedCodeCell"
    
    let cardView: UIView = {
        let cv = UIView()
        cv.backgroundColor = .white
        cv.layer.cornerRadius = 8
        cv.clipsToBounds = true
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    let topView: UIView = {
        let tv = UIView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    let avatarImage: WebImageView = {
        let nfa = WebImageView()
        nfa.layer.cornerRadius = 20
        nfa.clipsToBounds = true
        nfa.translatesAutoresizingMaskIntoConstraints = false
        return nfa
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0, green: 0.3124817436, blue: 0.5585669949, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.5768421292, green: 0.6187390685, blue: 0.664434731, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let bodyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    let postImageView: WebImageView = {
        let nfa = WebImageView()
        return nfa
    }()
    
    let bottomView: UIView = {
        let bv = UIView()
        return bv
    }()
    
    let likeView: UIView = {
        let lv = UIView()
        return lv
    }()
    
    let commentView: UIView = {
        let cv = UIView()
        return cv
    }()
    
    let sharesView: UIView = {
        let sv = UIView()
        return sv
    }()
    
    let viewsView: UIView = {
        let vv = UIView()
        return vv
    }()
    
    var stackView: UIStackView = {
        let sv = UIStackView()
        sv.distribution = .fillEqually
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let likesImage: UIImageView = {
        let li = UIImageView(image: UIImage(named: "like"))
        li.translatesAutoresizingMaskIntoConstraints = false
        return li
    }()
    
    let likesLabel: UILabel = {
        let ll = UILabel()
        ll.textColor = #colorLiteral(red: 0.5768421292, green: 0.6187390685, blue: 0.664434731, alpha: 1)
        ll.translatesAutoresizingMaskIntoConstraints = false

        return ll
    }()
    
    let commentImage: UIImageView = {
        let ci = UIImageView(image: UIImage(named: "comment"))
        ci.translatesAutoresizingMaskIntoConstraints = false
        return ci
    }()
    
    let commentLabel: UILabel = {
        let cl = UILabel()
        cl.textColor = #colorLiteral(red: 0.5768421292, green: 0.6187390685, blue: 0.664434731, alpha: 1)
        cl.translatesAutoresizingMaskIntoConstraints = false

        return cl
    }()
    
    let sharesImage: UIImageView = {
        let si = UIImageView(image: UIImage(named: "share"))
        si.translatesAutoresizingMaskIntoConstraints = false
        return si
    }()
    
    let sharesLabel: UILabel = {
        let sl = UILabel()
        sl.textColor = #colorLiteral(red: 0.5768421292, green: 0.6187390685, blue: 0.664434731, alpha: 1)
        sl.translatesAutoresizingMaskIntoConstraints = false
        return sl
    }()
    
    let viewsImage: UIImageView = {
        let vi = UIImageView(image: UIImage(named: "eye"))
        vi.translatesAutoresizingMaskIntoConstraints = false
        return vi
    }()
    
    let viewsLabel: UILabel = {
        let vl = UILabel()
        vl.textColor = #colorLiteral(red: 0.5768421292, green: 0.6187390685, blue: 0.664434731, alpha: 1)
        vl.translatesAutoresizingMaskIntoConstraints = false
        return vl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configure(with data: NewsfeedCellViewModel) {
        avatarImage.set(imageURL: data.avatarUrlString)
        titleLabel.text = data.title
        dateLabel.text = data.date
        bodyLabel.text = data.body
        likesLabel.text = data.likes
        commentLabel.text = data.comments
        sharesLabel.text = data.shares
        viewsLabel.text = data.views
        
        bodyLabel.frame = data.sizes.bodyLableFrame
        postImageView.frame = data.sizes.postImageViewFrame
        bottomView.frame = data.sizes.bottomView
        
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
        cardView.addSubview(topView)
        topView.addSubview(avatarImage)
        topView.addSubview(titleLabel)
        topView.addSubview(dateLabel)
        cardView.addSubview(bodyLabel)
        cardView.addSubview(postImageView)
        cardView.addSubview(bottomView)
        
        stackView.addSubviews(views: [likeView, commentView, sharesView, viewsView])
        bottomView.addSubview(stackView)
        
        likeView.addSubview(likesImage)
        commentView.addSubview(commentImage)
        sharesView.addSubview(sharesImage)
        viewsView.addSubview(viewsImage)
        likeView.addSubview(likesLabel)
        commentView.addSubview(commentLabel)
        sharesView.addSubview(sharesLabel)
        viewsView.addSubview(viewsLabel)
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2),
            
            topView.topAnchor.constraint(equalTo: cardView.topAnchor),
            topView.widthAnchor.constraint(equalTo: cardView.widthAnchor),
            topView.heightAnchor.constraint(equalToConstant: 56),
            
            avatarImage.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            avatarImage.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 8),
            avatarImage.heightAnchor.constraint(equalToConstant: 40),
            avatarImage.widthAnchor.constraint(equalToConstant: 40),
            
            titleLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -8),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            dateLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 8),
            dateLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -8),
            dateLabel.heightAnchor.constraint(equalToConstant: 13),
            
            stackView.topAnchor.constraint(equalTo: bottomView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor),
            
            likesImage.centerYAnchor.constraint(equalTo: likeView.centerYAnchor),
            likesImage.leadingAnchor.constraint(equalTo: likeView.leadingAnchor, constant: 10),
            likesImage.heightAnchor.constraint(equalToConstant: 25),
            likesImage.widthAnchor.constraint(equalToConstant: 25),
            
            commentImage.centerYAnchor.constraint(equalTo: commentView.centerYAnchor),
            commentImage.leadingAnchor.constraint(equalTo: commentView.leadingAnchor, constant: 10),
            commentImage.heightAnchor.constraint(equalToConstant: 25),
            commentImage.widthAnchor.constraint(equalToConstant: 25),
            
            sharesImage.centerYAnchor.constraint(equalTo: sharesView.centerYAnchor),
            sharesImage.leadingAnchor.constraint(equalTo: sharesView.leadingAnchor, constant: 10),
            sharesImage.heightAnchor.constraint(equalToConstant: 25),
            sharesImage.widthAnchor.constraint(equalToConstant: 25),
            
            viewsImage.centerYAnchor.constraint(equalTo: viewsView.centerYAnchor),
            viewsImage.leadingAnchor.constraint(equalTo: viewsView.leadingAnchor, constant: 10),
            viewsImage.heightAnchor.constraint(equalToConstant: 25),
            viewsImage.widthAnchor.constraint(equalToConstant: 25),
            
            likesLabel.centerYAnchor.constraint(equalTo: likesImage.centerYAnchor),
            likesLabel.leadingAnchor.constraint(equalTo: likesImage.trailingAnchor, constant: 4),
            likesLabel.trailingAnchor.constraint(equalTo: likeView.trailingAnchor, constant: 8),
            
            commentLabel.centerYAnchor.constraint(equalTo: commentImage.centerYAnchor),
            commentLabel.leadingAnchor.constraint(equalTo: commentImage.trailingAnchor, constant: 4),
            commentLabel.trailingAnchor.constraint(equalTo: commentView.trailingAnchor, constant: 8),
            
            sharesLabel.centerYAnchor.constraint(equalTo: sharesImage.centerYAnchor),
            sharesLabel.leadingAnchor.constraint(equalTo: sharesImage.trailingAnchor, constant: 4),
            sharesLabel.trailingAnchor.constraint(equalTo: sharesView.trailingAnchor, constant: 8),
            
            viewsLabel.centerYAnchor.constraint(equalTo: viewsImage.centerYAnchor),
            viewsLabel.leadingAnchor.constraint(equalTo: viewsImage.trailingAnchor, constant: 4),
            viewsLabel.trailingAnchor.constraint(equalTo: viewsView.trailingAnchor, constant: 8)

            ])
    }
}

extension UIStackView {
    func addSubviews(views: [UIView]) {
        views.forEach {self.addArrangedSubview($0)}
    }
}
