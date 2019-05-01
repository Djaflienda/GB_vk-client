//
//  extSearchBar.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 01/05/2019.
//  Copyright © 2019 MacBook-Игорь. All rights reserved.
//

import UIKit

extension FriendsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchText.isEmpty ?
            interactor?.makeRequest(request: .getFriendsList(alphabeticallySorted: alphabeticallySorted)) :
            interactor?.makeRequest(request: .getFriendsListFiltered(searchText: searchText, target: friends))
    }
}
