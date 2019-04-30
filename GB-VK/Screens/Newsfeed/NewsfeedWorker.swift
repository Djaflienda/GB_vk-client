//
//  NewsfeedWorker.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 26/04/2019.
//  Copyright (c) 2019 MacBook-Игорь. All rights reserved.
//

import UIKit

class NewsfeedService {
    
    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkManager())
    private var revealPostIds = [Int]()
    private var newsfeedResponse: NewsfeedResponse?
    private var newFromInProcess: String?
    
    func getNewsfeed(complition: @escaping ([Int], NewsfeedResponse)->Void) {
        fetcher.getNewsfeed(nextBatchFrom: nil) { [weak self] (newsfeedResponse) in
            self?.newsfeedResponse = newsfeedResponse
            guard let newsfeedResponse = self?.newsfeedResponse else { return }
            complition(self!.revealPostIds, newsfeedResponse)
        }
    }
    
    func revealPostIds(forPostId postId: Int, complition: @escaping ([Int], NewsfeedResponse)->Void) {
        revealPostIds.append(postId)
        guard let newsfeedResponse = self.newsfeedResponse else { return }
        complition(revealPostIds, newsfeedResponse)
    }
    
    func getNewsfeedBatch(complition: @escaping ([Int], NewsfeedResponse)->Void) {
        newFromInProcess = newsfeedResponse?.nextFrom
        fetcher.getNewsfeed(nextBatchFrom: newFromInProcess) { [weak self] (newsfeed) in
            guard let newsfeed = newsfeed else { return }
            guard self?.newsfeedResponse?.nextFrom != newsfeed.nextFrom else { return }
            
            if self?.newsfeedResponse == nil {
                self?.newsfeedResponse = newsfeed
            } else {
                self?.newsfeedResponse?.items.append(contentsOf: newsfeed.items)
                self?.newsfeedResponse?.nextFrom = newsfeed.nextFrom
                self?.newsfeedResponse?.profiles = newsfeed.profiles
                
                var profiles = newsfeed.profiles
                if let oldProfiles = self?.newsfeedResponse?.profiles {
                    let oldProfilesFiltered = oldProfiles.filter({ (oldProfile) -> Bool in
                        !newsfeed.profiles.contains(where: {$0.id == oldProfile.id})
                    })
                    profiles.append(contentsOf: oldProfilesFiltered)
                }
                self?.newsfeedResponse?.profiles = profiles
                
                var groups = newsfeed.groups
                if let oldGroups = self?.newsfeedResponse?.groups {
                    let oldGroupsFiltered = oldGroups.filter({ (oldGroup) -> Bool in
                        !newsfeed.groups.contains(where: {$0.id == oldGroup.id})
                    })
                    groups.append(contentsOf: oldGroupsFiltered)
                }
                self?.newsfeedResponse?.groups = groups
                
                self?.newsfeedResponse?.groups = newsfeed.groups

            }
            guard let newsfeedResponse = self?.newsfeedResponse else { return }
            complition(self!.revealPostIds, newsfeedResponse)
        }
    }
    
    
    

}
