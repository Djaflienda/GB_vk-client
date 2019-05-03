//
//  FriendPhotosRouter.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 29/04/2019.
//  Copyright (c) 2019 MacBook-Игорь. All rights reserved.
//

import UIKit

protocol FriendPhotosRoutingLogic {

}

protocol FriendPhotosDataPassing {
    var dataStore: FriendPhotosDataStore? { get }
}

class FriendPhotosRouter: NSObject, FriendPhotosRoutingLogic, FriendPhotosDataPassing {
    

    weak var viewController: FriendPhotosViewController?
    var dataStore: FriendPhotosDataStore?

  // MARK: Routing
  
}
