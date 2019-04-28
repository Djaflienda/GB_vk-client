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
}

final class NewsfeedLayoutCalculator {
    
    private let screenWidth: CGFloat
    
    init(screenWidth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
        self.screenWidth = screenWidth
    }
    
    func sizes(bodyText: String?, photoAttachment: NewsfeedCellPhotoAttachmentViewModel?) -> NewsfeedCellSizes {
        return Sizes(bodyLableFrame: CGRect.zero, postImageViewFrame: CGRect.zero)
    }
}
