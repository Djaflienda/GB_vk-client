//
//  NewsfeedViewController.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 26/04/2019.
//  Copyright (c) 2019 MacBook-Игорь. All rights reserved.
//

import UIKit

protocol NewsfeedDisplayLogic: class {
  func displayData(viewModel: Newsfeed.Model.ViewModel.ViewModelData)
}

class NewsfeedViewController: UIViewController, NewsfeedDisplayLogic {
    
    @IBOutlet weak var tableView: UITableView!
    
    var interactor: NewsfeedBusinessLogic?
    var router: (NSObjectProtocol & NewsfeedRoutingLogic)?
    private var newsfeedViewModel = NewsfeedViewModel(cells: [], footerTitle: nil)
    private lazy var footerView = FooterView()
    
    private var refreshControl: UIRefreshControl = {
        let rc = UIRefreshControl()
        rc.tintColor = .white
        rc.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return rc
    }()
  
    // MARK: Setup
  
    private func setup() {
        let viewController        = self
        let interactor            = NewsfeedInteractor()
        let presenter             = NewsfeedPresenter()
        let router                = NewsfeedRouter()
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
        tableView.register(NewsfeedCodeCell.self, forCellReuseIdentifier: NewsfeedCodeCell.reuseID)
        tableView.addSubview(refreshControl)
        tableView.tableFooterView = footerView
        interactor?.makeRequest(request: .getNewsfeed)
    }
    
    @objc func refresh() {
        interactor?.makeRequest(request: .getNewsfeed)
    }
  
    func displayData(viewModel: Newsfeed.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .displayNewsfeed(let viewModel):
            self.newsfeedViewModel = viewModel
            footerView.setTitle(title: newsfeedViewModel.footerTitle)
            tableView.reloadData()
            refreshControl.endRefreshing()
        case .displayFooterLoader:
            footerView.showLoader()
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y > scrollView.contentSize.height / 1.1 {
            interactor?.makeRequest(request: .getNewsfeedBatch)
        }
    }
}

extension NewsfeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return newsfeedViewModel.cells[indexPath.row].sizes.totalHeight
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return newsfeedViewModel.cells[indexPath.row].sizes.totalHeight
    }
}

extension NewsfeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsfeedViewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsfeedCodeCell.reuseID, for: indexPath) as! NewsfeedCodeCell
        cell.delegate = self
        cell.configure(with: newsfeedViewModel.cells[indexPath.row])
        return cell
    }
}

extension NewsfeedViewController: NewsfeedCodeCellDelegate {
    func revealPost(for cell: NewsfeedCodeCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let cellViewModel = newsfeedViewModel.cells[indexPath.row]
        
        interactor?.makeRequest(request: .revealPostIds(postId: cellViewModel.postId))
    }
}
