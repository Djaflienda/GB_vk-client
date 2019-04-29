//
//  FriendPhotosViewController.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 29/04/2019.
//  Copyright (c) 2019 MacBook-Игорь. All rights reserved.
//

import UIKit

protocol FriendPhotosDisplayLogic: class {
  func displayData(viewModel: FriendPhotos.Model.ViewModel.ViewModelData)
}

class FriendPhotosViewController: UIViewController, FriendPhotosDisplayLogic {
    
    @IBOutlet weak var collectionView: UICollectionView!

  var interactor: FriendPhotosBusinessLogic?
  var router: (NSObjectProtocol & FriendPhotosRoutingLogic)?
    private var friendPhotosViewModel = FriendPhotoViewModel(cells: [])

  // MARK: Setup
  
  private func setup() {
    let viewController        = self
    let interactor            = FriendPhotosInteractor()
    let presenter             = FriendPhotosPresenter()
    let router                = FriendPhotosRouter()
    viewController.interactor = interactor
    viewController.router     = router
    interactor.presenter      = presenter
    presenter.viewController  = viewController
    router.viewController     = viewController
  }
  
  // MARK: Routing
  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    interactor?.makeRequest(request: .getFriendPhotos)
  }

    func displayData(viewModel: FriendPhotos.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .displayFriendPhotos(let viewModel):
            self.friendPhotosViewModel = viewModel
            self.collectionView.reloadData()
        @unknown default:
            print("add new case")
        }
    }
  
}

extension FriendPhotosViewController: UICollectionViewDelegate {}

extension FriendPhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friendPhotosViewModel.cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FriendPhotoCell.reuseID, for: indexPath) as! FriendPhotoCell
        cell.configure(with: friendPhotosViewModel.cells[indexPath.row])
        return cell
    }
}
