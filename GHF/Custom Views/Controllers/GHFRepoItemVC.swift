//
//  GHFRepoItemVC.swift
//  GHF
//
//  Created by Yevhenii on 05.05.2020.
//  Copyright © 2020 Yevhenii. All rights reserved.
//

import UIKit

protocol GHFRepoItemVCDelegate: class {
    func didTapGiHubProfile(for user: User)
}

class GHFRepoItemVC: GHFItemInfoVC {

    weak var delegate: GHFRepoItemVCDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }

    private func configureItems() {
        itemInfoViewOne.set(itemType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
    }

    override func actionButtonTapped() {
        delegate?.didTapGiHubProfile(for: user)
    }

}
