//
//  NewsfeedLayoutCalculator.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 28/04/2019.
//  Copyright © 2019 MacBook-Игорь. All rights reserved.
//

import UIKit

protocol NewsfeedCellLayoutCalculatorProtocol {
    func sizes(bodyText: String?, photoAttachment: NewsfeedCellPhotoAttachmentViewModel?) -> NewsfeedCellSizes
}

struct Sizes: NewsfeedCellSizes {
    var bodyLableFrame: CGRect
    var postImageViewFrame: CGRect
    var bottomView: CGRect
    var totalHeight: CGFloat
}

struct Constants {

}

final class NewsfeedLayoutCalculator: NewsfeedCellLayoutCalculatorProtocol {
    
    private let screenWidth: CGFloat
    
    init(screenWidth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
        self.screenWidth = screenWidth
    }
    
    func sizes(bodyText: String?, photoAttachment: NewsfeedCellPhotoAttachmentViewModel?) -> NewsfeedCellSizes {
        
        var bodyLabelFrame = CGRect(origin: CGPoint(x: 10, y: 56),
                                    size: CGSize.zero)
        
        if let text = bodyText, !text.isEmpty {
            let width = screenWidth - 20
            let height = text.height(width: width, font: UIFont.systemFont(ofSize: 15))
            bodyLabelFrame.size = CGSize(width: width, height: height)
        }
        
        let postImageViewTop = bodyLabelFrame.size == CGSize.zero ? 64 : bodyLabelFrame.maxY + 8
        
        var postImageViewFrame = CGRect(origin: CGPoint(x: 0, y: postImageViewTop),
                                        size: CGSize.zero)
        if let attachment = photoAttachment {
            let ratio = Float(attachment.height) / Float(attachment.width)
            let imageHeight = (screenWidth - 4) * CGFloat(ratio)
            postImageViewFrame.size = CGSize(width: screenWidth - 4, height: imageHeight)
        }
        
        let bottomViewTop = max(bodyLabelFrame.maxY, postImageViewFrame.maxY)
        let bottomViewFrame = CGRect(origin: CGPoint(x: 0, y: bottomViewTop + 8), size: CGSize(width: postImageViewFrame.size.width, height: 40))
        
        
        let totalHeight = bottomViewFrame.maxY + 8
        
        return Sizes(bodyLableFrame: bodyLabelFrame, postImageViewFrame: postImageViewFrame, bottomView: bottomViewFrame, totalHeight: totalHeight)
    }
}
