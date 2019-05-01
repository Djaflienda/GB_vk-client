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

class FriendsRouter: NSObject, FriendsRoutingLogic {
    
    weak var viewController: FriendsViewController?
    
    // MARK: Routing
    
    func routeToFriendPhotos(segue: UIStoryboardSegue?) {
        if let _ = segue {
            //fill this  space if use segues
        } else {
            let storyboard = UIStoryboard(name: "FriendPhotos", bundle: nil)
            let destinationVC = storyboard.instantiateViewController(withIdentifier: "FriendPhotos") as! FriendPhotosViewController
            navigateToFriendPhotos(source: viewController!, destination: destinationVC)
        }
    }
    
    //MARK: Navigation
    
    private func navigateToFriendPhotos(source: FriendsViewController, destination: FriendPhotosViewController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
}
