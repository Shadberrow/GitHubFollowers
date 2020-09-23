//
//  GHFUserInfoHeaderVC.swift
//  GHF
//
//  Created by Yevhenii on 05.05.2020.
//  Copyright © 2020 Yevhenii. All rights reserved.
//

import UIKit

class GHFUserInfoHeaderVC: UIViewController {

    let avatarImageView     = GHFAvatarImageView(frame: .zero)
    let userNameLabel       = GHFTitleLabel(textAlignment: .left, fontSize: 34)
    let nameLabel           = GHFSecondaryTitleLabel(fontSize: 18)
    let locationImageView   = UIImageView()
    let locationLabel       = GHFSecondaryTitleLabel(fontSize: 18)
    let bioLabel            = GHFBodyLabel(textAlignment: .left)

    var user: User!

    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.backgroundColor = .systemBackground

        setupSubviews()
        addSubviews()
        setupConstraints()
    }

    private func setupSubviews() {
        userNameLabel.text      = user.login
        nameLabel.text          = user.name ?? ""
        locationImageView.image = SFSymbols.locationPin
        locationImageView.tintColor = .secondaryLabel
        locationLabel.text      = user.location ?? "No Location"
        bioLabel.text           = user.bio ?? "No BIO Available"
        bioLabel.numberOfLines  = 3

        // Download user profile image and set to the avatar UIImageView
        NetworkManager.shared.downloadImage(from: user.avatarUrl) { [weak self] (image) in
            guard let self = self else { return }
            DispatchQueue.main.async { self.avatarImageView.image = image }
        }
    }

    private func addSubviews() {
        view.addSubview(avatarImageView)
        view.addSubview(userNameLabel)
        view.addSubview(nameLabel)
        view.addSubview(locationImageView)
        view.addSubview(locationLabel)
        view.addSubview(bioLabel)
    }

    private func setupConstraints() {
        let padding: CGFloat = 20
        let imagePadding: CGFloat = 12

        avatarImageView.pin(.top, to: view.top, constant: padding)
        avatarImageView.pin(.leading, to: view.leading)
        avatarImageView.square(90)

        userNameLabel.pin(.top, to: avatarImageView.top)
        userNameLabel.pin(.leading, to: avatarImageView.trailing, constant: imagePadding)
        userNameLabel.pin(.trailing, to: view.trailing)
//        userNameLabel.height(38)

        nameLabel.centerY(in: avatarImageView, constant: 8)
        nameLabel.pin(.leading, to: avatarImageView.trailing, constant: imagePadding)
        nameLabel.pin(.trailing, to: view.trailing)
//        nameLabel.height(20)

        locationImageView.pin(.bottom, to: avatarImageView.bottom)
        locationImageView.pin(.leading, to: avatarImageView.trailing, constant: imagePadding)
        locationImageView.square(20)

        locationLabel.centerY(in: locationImageView)
        locationLabel.pin(.leading, to: locationImageView.trailing, constant: 5)
        locationLabel.pin(.trailing, to: view.trailing)
//        locationLabel.height(20)

        bioLabel.pin(.top, to: avatarImageView.bottomAnchor, constant: imagePadding)
        bioLabel.pin(.leading, to: avatarImageView.leadingAnchor)
        bioLabel.pin(.trailing, to: view.trailing)
//        bioLabel.height(60)

    }

}
