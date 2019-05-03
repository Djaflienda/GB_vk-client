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
    var router: (NSObjectProtocol & FriendPhotosRoutingLogic & FriendPhotosDataPassing)?
    private var friendPhotosViewModel: FriendPhotoViewModel!
    
    // MARK: Setup
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
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
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.makeRequest(request: .getFriendPhotos)
    }
    
    func displayData(viewModel: FriendPhotos.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .displayFriendPhotos(let viewModel):
            self.friendPhotosViewModel = viewModel
            self.collectionView.reloadData()
            title = friendPhotosViewModel.profileName
        }
    }
}

extension FriendPhotosViewController: UICollectionViewDelegate {}

extension FriendPhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friendPhotosViewModel.avatarUrlStrings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FriendPhotoCell.reuseID, for: indexPath) as! FriendPhotoCell
        cell.configure(with: friendPhotosViewModel, at: indexPath.row)
        return cell
    }
}

extension FriendPhotosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 3 - 8
        return CGSize(width: width, height: width)
    }
}
