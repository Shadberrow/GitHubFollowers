//
//  FavoritesListVC.swift
//  GHF
//
//  Created by Yevhenii on 24.03.2020.
//  Copyright © 2020 Yevhenii. All rights reserved.
//

import UIKit


class FavoritesListVC: GHFDataLoadingController {

    private var tableView: UITableView!
    private var favorites: [Follower] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        retreiveFavorites()
    }

    private func setupView() {
        view.backgroundColor = .systemBackground
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true

        setupSubviews()
        addSubviews()
        setupConstraints()
    }

    private func setupSubviews() {
        tableView               = UITableView()
        tableView.delegate      = self
        tableView.dataSource    = self
        tableView.rowHeight     = 80
        tableView.tableFooterView = UIView()
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseIdentifier)
    }

    private func addSubviews() {
        view.addSubview(tableView)
    }

    private func setupConstraints() {
        tableView.fill(in: view)
    }

    private func retreiveFavorites() {
        PersistanceManager.retreiveFavorites { [weak self] (result) in
            guard let self = self else { return }

            switch result {
            case let .success(favorites):
                self.updateUI(with: favorites)
            case let .failure(error):
                self.presentGHFAlretOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }

    private func updateUI(with favorites: [Follower]) {
        if favorites.isEmpty {
            self.showEmptyStateView(with: "No Favorites?\nAdd one on the follower screen.", in: self.view)
        } else {
            self.favorites = favorites
            DispatchQueue.main.async { self.tableView.reloadData(); self.removeEmptyStateView() }
        }
    }

}


extension FavoritesListVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseIdentifier) as! FavoriteCell
        cell.set(favorite: favorites[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite        = favorites[indexPath.row]
        let destVC          = FollowerListVC(user: favorite.login)

        navigationController?.pushViewController(destVC, animated: true)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        PersistanceManager.updateWith(favorite: favorites[indexPath.row], actionType: .remove) { [weak self] (error) in
            guard let self = self else { return }
            guard let error = error else {
                self.favorites.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                return
            }
            self.presentGHFAlretOnMainThread(title: "Unable to remove", message: error.rawValue, buttonTitle: "Ok")
        }
    }

}
