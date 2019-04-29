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
        case .presentNewsfeed(let response):
            let cells = response.items.map { (newsfeedItem) in
                cellViewModel(from: newsfeedItem, profiles: response.profiles, groups: response.groups)
            }
            let viewModel = NewsfeedViewModel(cells: cells)
            viewController?.displayData(viewModel: .displayNewsfeed(viewModel: viewModel))
        @unknown default:
            print("add new case")
        }
    }
    
    private func cellViewModel(from newsfeedItem: NewsfeedItem, profiles: [Profile], groups: [NewsfeedGroup]) -> NewsfeedViewModel.Cell {
        let profile = self.profile(for: newsfeedItem.sourceId, profiles: profiles, groups: groups)
        let photoAttachment = self.photoAttachment(newsfeedItem: newsfeedItem)
        let date = Date(timeIntervalSince1970: newsfeedItem.date)
        let dateTitle = dateFormatter.string(from: date)
        let sizes = newsfeedCellLayoutCalculator.sizes(bodyText: newsfeedItem.text, photoAttachment: photoAttachment)
        return NewsfeedViewModel.Cell(avatarUrlString: profile.photo,
                                      title: profile.name,
                                      date: dateTitle,
                                      body: newsfeedItem.text,
                                      likes: String(newsfeedItem.likes?.count ?? 0),
                                      comments: String(newsfeedItem.comments?.count ?? 0),
                                      shares: String(newsfeedItem.reposts?.count ?? 0),
                                      views: String(newsfeedItem.views?.count ?? 0),
                                      photoAttachment: photoAttachment,
                                      sizes: sizes)
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
