//
//  NewsfeedResponse.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 26/04/2019.
//  Copyright © 2019 MacBook-Игорь. All rights reserved.
//

import Foundation

struct NewsfeedResponseWrapped: Codable {
    let response: NewsfeedResponse
}

struct NewsfeedResponse: Codable {
    var items: [NewsfeedItem]
    var profiles: [Profile]
    var groups: [NewsfeedGroup]
    var nextFrom: String?
}

protocol ProfileRepresentable {
    var id: Int { get }
    var name: String { get }
    var photo: String { get }
}

struct NewsfeedGroup: Codable, ProfileRepresentable {
    let id: Int
    let name: String
    let photo100: String
    var photo: String { return photo100 }
}

struct Profile: Codable, ProfileRepresentable {
    let id: Int
    let firstName: String
    let lastName: String
    let photo100: String
    var name: String { return firstName + " " + lastName }
    var photo: String { return photo100 }
}

struct NewsfeedItem: Codable {
    let sourceId: Int
    let postId: Int
    let text: String?
    let date: Double
    let comments: CountableItem?
    let likes: CountableItem?
    let reposts: CountableItem?
    let views: CountableItem?
    let attachments: [Attachment]?
}

struct Attachment: Codable {
    let photo: Photo?
}

struct Photo: Codable {
    let sizes: [PhotoSize]
    var height: Int {
        return getProperSize().height
    }
    var width: Int {
        return getProperSize().width
    }
    var srcBIG: String {
        return getProperSize().url
    }
    
    private func getProperSize() -> PhotoSize {
        if let sizeX = sizes.first(where: { $0.type == "x" }) {
            return sizeX
        } else if let fallBackSize = sizes.last {
            return fallBackSize
        } else {
            return PhotoSize(type: "wrong image url", url: "wrong image", width: 0, height: 0)
        }
    }
}

struct PhotoSize: Codable {
    let type: String
    let url: String
    let width: Int
    let height: Int
}

struct CountableItem: Codable {
    let count: Int
}
