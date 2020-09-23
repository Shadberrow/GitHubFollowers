//
//  GHFFollowerItemVC.swift
//  GHF
//
//  Created by Yevhenii on 05.05.2020.
//  Copyright © 2020 Yevhenii. All rights reserved.
//

import UIKit

protocol GHFFollowerItemVCDelegate: class {
    func didTapFollowers(for user: User)
}

class GHFFollowerItemVC: GHFItemInfoVC {

    weak var delegate: GHFFollowerItemVCDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }

    private func configureItems() {
        itemInfoViewOne.set(itemType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }

    override func actionButtonTapped() {
        delegate?.didTapFollowers(for: user)
    }

}
