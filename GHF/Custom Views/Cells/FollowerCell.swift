//
//  FollowerCell.swift
//  GHF
//
//  Created by Yevhenii on 07.04.2020.
//  Copyright © 2020 Yevhenii. All rights reserved.
//

import UIKit

class FollowerCell: UICollectionViewCell {

    private let padding: CGFloat = 8

    let avatarImageView = GHFAvatarImageView(frame: .zero)
    let userNameLabel   = GHFTitleLabel(textAlignment: .center, fontSize: 16)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    private func setupView() {

        setupSubviews()
        addSubviews()
        setupConstraints()
    }

    private func setupSubviews() {

    }

    private func addSubviews() {
        addSubview(avatarImageView)
        addSubview(userNameLabel)
    }

    private func setupConstraints() {
        avatarImageView.pin(.top, to: contentView.top, constant: padding)
        avatarImageView.pin(.leading, to: contentView.leading, constant: padding)
        avatarImageView.pin(.trailing, to: contentView.trailing, constant: padding)
        avatarImageView.height(equalTo: avatarImageView.width, multiplier: 1)

        userNameLabel.pin(.top, to: avatarImageView.bottom, constant: 12)
        userNameLabel.centerX(in: avatarImageView)
        userNameLabel.width(equalTo: avatarImageView.width, multiplier: 1)
    }

    func set(follower: Follower) {
        userNameLabel.text = follower.login
        avatarImageView.downloadImage(from: follower.avatarUrl)
    }

}
