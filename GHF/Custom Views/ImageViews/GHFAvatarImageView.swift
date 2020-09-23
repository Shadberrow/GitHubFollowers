//
//  GHFAvatarImageView.swift
//  GHF
//
//  Created by Yevhenii on 07.04.2020.
//  Copyright © 2020 Yevhenii. All rights reserved.
//

import UIKit

class GHFAvatarImageView: UIImageView {

    let placeholderImage = Images.avatarPlaceholder

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    private func setupView() {
        layer.cornerRadius  = 10
        clipsToBounds       = true
        image               = placeholderImage
    }

}
