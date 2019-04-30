//
//  NewsfeedPresenter.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 26/04/2019.
//  Copyright (c) 2019 MacBook-Игорь. All rights reserved.
//

import UIKit

protocol NewsfeedPresentationLogic {
    func presentData(response: Newsfeed.Model.Response.ResponseType)
}

class NewsfeedPresenter: NewsfeedPresentationLogic {
    
    weak var viewController: NewsfeedDisplayLogic?
    private var newsfeedCellLayoutCalculator = NewsfeedLayoutCalculator()
    private let dateFormatter: DateFormatter = {
        let dt = DateFormatter()
        dt.locale = Locale(identifier: "ru_RU")
        dt.dateFormat = "d MMM 'в' HH:mm"
        return dt
    }()
  
    func presentData(response: Newsfeed.Model.Response.ResponseType) {
        switch response {
        case .presentNewsfeed(let response, let revealPostIds):
            print(revealPostIds)
            let cells = response.items.map { (newsfeedItem) in
                cellViewModel(from: newsfeedItem, profiles: response.profiles, groups: response.groups, revealPostIds: revealPostIds)
            }
            let viewModel = NewsfeedViewModel(cells: cells, footerTitle: "\(cells.count) posts")
            viewController?.displayData(viewModel: .displayNewsfeed(viewModel: viewModel))
        case .presentFooterLoader:
            viewController?.displayData(viewModel: .displayFooterLoader)
        }
    }
    
    private func cellViewModel(from newsfeedItem: NewsfeedItem, profiles: [Profile], groups: [NewsfeedGroup], revealPostIds: [Int]) -> NewsfeedViewModel.Cell {
        let profile = self.profile(for: newsfeedItem.sourceId, profiles: profiles, groups: groups)
        let photoAttachment = self.photoAttachment(newsfeedItem: newsfeedItem)
        let date = Date(timeIntervalSince1970: newsfeedItem.date)
        let dateTitle = dateFormatter.string(from: date)
        
        let isFullsized = revealPostIds.contains(newsfeedItem.postId)
        
        let sizes = newsfeedCellLayoutCalculator.sizes(bodyText: newsfeedItem.text, photoAttachment: photoAttachment, isFullSizedPost: isFullsized)
        return NewsfeedViewModel.Cell(postId: newsfeedItem.postId, avatarUrlString: profile.photo,
                                      title: profile.name,
                                      date: dateTitle,
                                      body: newsfeedItem.text,
                                      likes: formattedCounter(newsfeedItem.likes?.count),
                                      comments: formattedCounter(newsfeedItem.comments?.count),
                                      shares: formattedCounter(newsfeedItem.reposts?.count),
                                      views: formattedCounter(newsfeedItem.views?.count),
                                      photoAttachment: photoAttachment,
                                      sizes: sizes)
    }
    
    private func formattedCounter(_ counter: Int?) -> String? {
        guard let counter = counter, counter > 0 else {
            return nil
        }
        var counterString = String(counter)
        if 4...6 ~= counterString.count {
            counterString = String(counterString.dropLast(3)) + "K"
        } else if counterString.count > 6 {
            counterString = String(counterString.dropLast(6)) + "M"
        }
        return counterString
    }
    
    private func profile(for sourceId: Int, profiles: [Profile], groups: [NewsfeedGroup]) -> ProfileRepresentable {
        let profileOrGroups: [ProfileRepresentable] = sourceId > 0 ? profiles : groups
        let normalSourceId = sourceId > 0 ? sourceId : -sourceId
        let profileRepresentable = profileOrGroups.first { (myProfileRepresentable) -> Bool in
            myProfileRepresentable.id == normalSourceId
        }
        return profileRepresentable!
    }
    
    private func photoAttachment(newsfeedItem: NewsfeedItem) -> NewsfeedViewModel.FeedCellPhotoAttachment? {
        guard let photos = newsfeedItem.attachments?.compactMap({ (attachment) in
            attachment.photo
        }), let firstPhoto = photos.first else {
            return nil
        }
        return NewsfeedViewModel.FeedCellPhotoAttachment(photoUrlString: firstPhoto.srcBIG,
                                                         width: firstPhoto.width,
                                                         height: firstPhoto.height)
    }
}
