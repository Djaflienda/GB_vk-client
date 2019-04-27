//
//  SearchManager.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 23/04/2019.
//  Copyright © 2019 MacBook-Игорь. All rights reserved.
//

struct SearchingManager<T> {
    var searchingResult = [T]()
    
    mutating func searchingFilter(for text: String, in array: [T]) {
        searchingResult.removeAll()
        
        if let array = array as? [Friend] {
            let nameSortedArray = array.filter {$0.profileName.lowercased().prefix(text.count) == text.lowercased()} as! [T]
            let surnameSortedArray = array.filter {$0.profileSurname.lowercased().prefix(text.count) == text.lowercased()} as! [T]
            searchingResult.append(contentsOf: nameSortedArray)
            searchingResult.append(contentsOf: surnameSortedArray)
        }
        if let array = array as? [Group] {
            let groupNameSortedArray = array.filter {$0.groupName.lowercased().prefix(text.count) == text.lowercased()} as! [T]
            searchingResult.append(contentsOf: groupNameSortedArray)
        }
    }
}
