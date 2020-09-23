//
//  GHFTabBarController.swift
//  GHF
//
//  Created by Yevhenii on 08.05.2020.
//  Copyright © 2020 Yevhenii. All rights reserved.
//

import UIKit

class GHFTabBarController: UITabBarController {

    private var searchNavigationController    : UINavigationController!
    private var favoritesNavigationController : UINavigationController!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        UITabBar.appearance().tintColor = .systemGreen

        setupSubviews()
        addSubviews()
        setupConstraints()
    }

    private func setupSubviews() {
        searchNavigationController      = createTabController(controller: SearchVC(),
                                                              title: "Search",
                                                              icon: .search,
                                                              tag: 0)
        favoritesNavigationController   = createTabController(controller: FavoritesListVC(),
                                                              title: "Favorites",
                                                              icon: .favorites,
                                                              tag: 1)
    }

    private func addSubviews() {
        createTabbar(with: [
            searchNavigationController,
            favoritesNavigationController
        ])
    }

    private func setupConstraints() {

    }

    private func createTabController<T: UIViewController>(controller: T, title: String, icon: UITabBarItem.SystemItem, tag: Int) -> UINavigationController {
        controller.title = title
        controller.tabBarItem = UITabBarItem(tabBarSystemItem: icon, tag: tag)
        return UINavigationController(rootViewController: controller)
    }


    private func createTabbar(with viewControllers: [UIViewController]) {
        self.viewControllers = viewControllers
    }

}
