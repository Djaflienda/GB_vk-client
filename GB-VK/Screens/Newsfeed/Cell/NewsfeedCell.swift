//
//  NewsfeedCell.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 26/04/2019.
//  Copyright © 2019 MacBook-Игорь. All rights reserved.
//

import UIKit

protocol NewsfeedCellViewModel {
    var avatarUrlString: String { get }
    var title: String { get }
    var date: String { get }
    var body: String? { get }
    var likes: String? { get }
    var comments: String? { get }
    var shares: String? { get }
    var views: String? { get }
    var photoAttachment: NewsfeedCellPhotoAttachmentViewModel? { get }
}

protocol NewsfeedCellPhotoAttachmentViewModel {
    var photoUrlString: String? { get }
    var width: Int { get }
    var height: Int { get }
}

class NewsfeedCell: UITableViewCell {

    static let reuseID = "NewsfeedCell"
    
    @IBOutlet weak var avatarImage: WebImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var sharesLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    @IBOutlet weak var postImageView: WebImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
        if let photoAttachment = data.photoAttachment {
            postImageView.set(imageURL: photoAttachment.photoUrlString)
            postImageView.isHidden = false
        } else {
            postImageView.isHidden = true
        }
    }
    
}
