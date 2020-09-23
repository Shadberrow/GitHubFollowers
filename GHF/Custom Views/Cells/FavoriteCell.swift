//
//  FavoriteCell.swift
//  GHF
//
//  Created by Yevhenii on 08.05.2020.
//  Copyright © 2020 Yevhenii. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {

    private var avatarImageView : GHFAvatarImageView!
    private var usernameLabel   : GHFTitleLabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    private func setupView() {
        accessoryType = .disclosureIndicator

        setupSubviews()
        addSubviews()
        setupConstraints()
    }

    private func setupSubviews() {
        avatarImageView     = GHFAvatarImageView(frame: .zero)
        usernameLabel       = GHFTitleLabel(textAlignment: .left, fontSize: 26)
    }

    private func addSubviews() {
        addSubview(avatarImageView)
        addSubview(usernameLabel)
    }

    private func setupConstraints() {
        let padding: CGFloat = 12

        avatarImageView.pin(.leading, to: self.leading, constant: padding)
        avatarImageView.centerY(in: self)
        avatarImageView.square(60)

        usernameLabel.centerY(in: avatarImageView)
        usernameLabel.pin(.leading, to: avatarImageView.trailing, constant: 24)
        usernameLabel.pin(.trailing, to: self.trailing, constant: padding)
        usernameLabel.height(40)
    }

    func set(favorite: Follower) {
        usernameLabel.text = favorite.login
        NetworkManager.shared.downloadImage(from: favorite.avatarUrl) { [weak self] (image) in
            guard let self = self else { return }
            DispatchQueue.main.async { self.avatarImageView.image = image }
        }
    }

}
