//
//  FollowerListVC.swift
//  GHF
//
//  Created by Yevhenii on 01.04.2020.
//  Copyright © 2020 Yevhenii. All rights reserved.
//

import UIKit

class FollowerListVC: GHFDataLoadingController {

    enum Section {
        case main
    }

    private var followers           : [Follower] = []
    private var filteredFollowers   : [Follower] = []

    private var username            : String
    private var page                : Int = 1
    private var hasMoreFollowers    : Bool = true
    private var isSearching         : Bool = false
    private var isLoading           : Bool = false

    private var collectionFlowLayout: UICollectionViewFlowLayout!
    private var collectionView      : UICollectionView!
    private var dataSource          : UICollectionViewDiffableDataSource<Section, Follower>!

    private let searchController    = UISearchController()
    private var addBarButtonItem    : UIBarButtonItem!

    init(user: String) {
        username = user
        super.init(nibName: nil, bundle: nil)
        title = user
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    private func setupView() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true

        setupSubviews()
        addSubviews()
        setupConstraints()
        getFollowers(username: username, page: page)
    }

    private func setupSubviews() {
        collectionFlowLayout                = UIHelper.createThreeColumnFlowLayout(in: view .bounds)

        collectionView                      = UICollectionView(frame: .zero, collectionViewLayout: collectionFlowLayout)
        collectionView.backgroundColor      = .systemBackground
        collectionView.delegate             = self
        collectionView.alwaysBounceVertical = true
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseIdentifier)

        dataSource                          = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: {
            (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseIdentifier, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })

        searchController.searchResultsUpdater   = self
        searchController.searchBar.placeholder  = "Search for a username"
//        searchController.obscuresBackgroundDuringPresentation = false

        navigationItem.searchController = searchController

        addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAdd))
    }

    private func addSubviews() {
        navigationItem.rightBarButtonItem = addBarButtonItem

        view.addSubview(collectionView)
    }

    private func setupConstraints() {
        collectionView.fill(in: view)
    }

    private func getFollowers(username: String, page: Int) {
        showLoadingView()
        isLoading = true

        NetworkManager.shared.getFollowers(for: username, page: page) { [unowned self] result in
            self.dismissLoadingView()

            switch result {
            case let .success(followers):
                self.updateUI(with: followers)
            case let .failure(error):
                self.presentGHFAlretOnMainThread(title: "Bad Stuff Happend", message: error.rawValue, buttonTitle: "Ok")
            }

            self.isLoading = false
        }
    }

    private func updateUI(with followers: [Follower]) {
        if followers.count < 100 { self.hasMoreFollowers = false }
        self.followers.append(contentsOf: followers)
        if self.followers.isEmpty {
            let message = "This user doesn't have any followers. Go follow them 😃."
            DispatchQueue.main.async { self.showEmptyStateView(with: message, in: self.view) }
            return
        }
        self.updateData(on: self.followers)
    }

    private func updateData(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)

        self.dataSource.apply(snapshot, animatingDifferences: true)
    }

}


extension FollowerListVC: UICollectionViewDelegate {

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.size.height

        if offsetY > contentHeight - height {
            guard hasMoreFollowers, !isLoading else { return }
            page += 1
            getFollowers(username: username, page: page)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let follower = isSearching ? filteredFollowers[indexPath.item] : followers[indexPath.item]

        let vc = UserInfoVC()
        vc.userName = follower.login
        vc.delegate = self
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true)
    }

    @objc
    private func handleAdd() {
        showLoadingView()
        NetworkManager.shared.getUserInfo(for: username) { [weak self] (result) in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
            case let .success(user):
                self.addUserToFavorites(user: user)
            case let .failure(error):
                self.presentGHFAlretOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }

    private func addUserToFavorites(user: User) {
        let follower = Follower(login: user.login, avatarUrl: user.avatarUrl)
        PersistanceManager.updateWith(favorite: follower, actionType: .add) { (error) in
            guard let error = error else {
                self.presentGHFAlretOnMainThread(title: "Yyeeeaahh!", message: "The user has been successfully added to yout favorites list", buttonTitle: "Ok")
                return
            }
            self.presentGHFAlretOnMainThread(title: "Oops!", message: error.rawValue, buttonTitle: "Ok")
        }
    }

}


extension FollowerListVC: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            isSearching = false
            filteredFollowers.removeAll()
            updateData(on: followers)
            return
        }

        isSearching = true
        filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredFollowers)
    }

}


extension FollowerListVC: UserInfoVCDelegate {

    func didRequestFollowers(for username: String) {
        self.username   = username
        title           = username
        page            = 1

        followers.removeAll()
        filteredFollowers.removeAll()

        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        getFollowers(username: username, page: page)
    }

}
