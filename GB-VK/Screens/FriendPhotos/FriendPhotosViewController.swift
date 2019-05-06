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
    
    @objc func showPhoto(startPosition: CGRect, index: Int) {
        let photo = UIImageView(frame: startPosition)
        photo.image = UIImage(named: friendPhotosViewModel.avatarUrlStrings[index])
        collectionView.isHidden = true
        view.addSubview(photo)
        UIView.animate(withDuration: 0.5) {
            photo.frame = .init(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.width)
            photo.center = self.view.center
        }
//        let tapGR = UITapGestureRecognizer(target: self, action: #selector(dismissPhoto))
    }
    
    @objc func dismissPhoto(sender: UITapGestureRecognizer) {
       
    }
}

extension FriendPhotosViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let targetFrame = collectionView.cellForItem(at: indexPath)?.frame
        let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
        guard let topBarHeight =  navigationController?.navigationBar.frame.height,
            let xPosition = targetFrame?.origin.x,
            let yPosition = targetFrame?.origin.y,
            let width = targetFrame?.width,
            let height = targetFrame?.height else { return }
        let startFrame: CGRect = .init(x: xPosition, y: yPosition + statusBarHeight + topBarHeight, width: width, height: height)
        showPhoto(startPosition: startFrame, index: indexPath.row)
        
        
    }
}

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
