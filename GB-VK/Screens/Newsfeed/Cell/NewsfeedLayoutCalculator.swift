//
//  NewsfeedLayoutCalculator.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 28/04/2019.
//  Copyright © 2019 MacBook-Игорь. All rights reserved.
//

import UIKit

protocol NewsfeedCellLayoutCalculatorProtocol {
    func sizes(bodyText: String?, photoAttachment: NewsfeedCellPhotoAttachmentViewModel?, isFullSizedPost: Bool) -> NewsfeedCellSizes
}

struct Sizes: NewsfeedCellSizes {
    var bodyLableFrame: CGRect
    var moreTextButtonFrame: CGRect
    var postImageViewFrame: CGRect
    var bottomView: CGRect
    var totalHeight: CGFloat
}

final class NewsfeedLayoutCalculator: NewsfeedCellLayoutCalculatorProtocol {
    
    private let screenWidth: CGFloat
    
    init(screenWidth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
        self.screenWidth = screenWidth
    }
    
    func sizes(bodyText: String?, photoAttachment: NewsfeedCellPhotoAttachmentViewModel?, isFullSizedPost: Bool) -> NewsfeedCellSizes {
        var showMoreTextButton = false
        var bodyLabelFrame = CGRect(origin: CGPoint(x: 10, y: 56), size: CGSize.zero)
        if let text = bodyText, !text.isEmpty {
            let width = screenWidth - 20
            var height = text.height(width: width, font: UIFont.systemFont(ofSize: 15))
            let limitHeight = (UIFont.systemFont(ofSize: 15).lineHeight) * CGFloat(8)
            if !isFullSizedPost && height > limitHeight {
                height = (UIFont.systemFont(ofSize: 15).lineHeight) * CGFloat(6)
                showMoreTextButton = true
            }
            bodyLabelFrame.size = CGSize(width: width, height: height)
        }
        var moreTextButtonSize = CGSize.zero
        if showMoreTextButton {
            moreTextButtonSize = CGSize(width: 160, height: 30)
        }
        let moreTextButtonOrigin = CGPoint(x: 10, y: bodyLabelFrame.maxY)
        let moreTextButtonFrame = CGRect(origin: moreTextButtonOrigin, size: moreTextButtonSize)
        let postImageViewTop = bodyLabelFrame.size == CGSize.zero ? 64 : moreTextButtonFrame.maxY + 8
        var postImageViewFrame = CGRect(origin: CGPoint(x: 0, y: postImageViewTop), size: CGSize.zero)
        if let attachment = photoAttachment {
            let ratio = Float(attachment.height) / Float(attachment.width)
            let imageHeight = (screenWidth - 4) * CGFloat(ratio)
            postImageViewFrame.size = CGSize(width: screenWidth - 4, height: imageHeight)
        }
        let bottomViewTop = max(bodyLabelFrame.maxY, postImageViewFrame.maxY)
        let bottomViewFrame = CGRect(origin: CGPoint(x: 0, y: bottomViewTop), size: CGSize(width: screenWidth - 4, height: 40))
        let totalHeight = bottomViewFrame.maxY + 8
        
        return Sizes(bodyLableFrame: bodyLabelFrame, moreTextButtonFrame: moreTextButtonFrame, postImageViewFrame: postImageViewFrame, bottomView: bottomViewFrame, totalHeight: totalHeight)
    }
}
