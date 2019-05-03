//
//  FriendsRouter.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 26/04/2019.
//  Copyright (c) 2019 MacBook-Игорь. All rights reserved.
//

import UIKit

protocol FriendsRoutingLogic {
    func routeToFriendPhotos(segue: UIStoryboardSegue?)
}

protocol FriendsDataPassing {
    var dataStore: FriendsDataStore? { get }
}

class FriendsRouter: NSObject, FriendsRoutingLogic, FriendsDataPassing {
    
    weak var viewController: FriendsViewController?
    var dataStore: FriendsDataStore?
    
    // MARK: Routing
    
    func routeToFriendPhotos(segue: UIStoryboardSegue?) {
        if let _ = segue {
            //fill this  space if use segues
        } else {
            let storyboard = UIStoryboard(name: "FriendPhotos", bundle: nil)
            let destinationVC = storyboard.instantiateViewController(withIdentifier: "FriendPhotos") as! FriendPhotosViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToFriendPhotos(source: dataStore!, destination: &destinationDS)
            navigateToFriendPhotos(source: viewController!, destination: destinationVC)
        }
    }
    
    //MARK: Navigation
    
    private func navigateToFriendPhotos(source: FriendsViewController, destination: FriendPhotosViewController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    
    private func passDataToFriendPhotos(source: FriendsDataStore, destination: inout FriendPhotosDataStore) {
        destination.userID = source.userID
    }
}
