//
//  GHFItemInfoView.swift
//  GHF
//
//  Created by Yevhenii on 05.05.2020.
//  Copyright © 2020 Yevhenii. All rights reserved.
//

import UIKit

enum ItemInfoType {
    case repos, gists, followers, following
}

class GHFItemInfoView: UIView {

    private var symbolImageView : UIImageView!
    private var titleLabel      : GHFTitleLabel!
    private var countLabel      : GHFTitleLabel!

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
        symbolImageView             = UIImageView()
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.tintColor   = .label
        titleLabel                  = GHFTitleLabel(textAlignment: .left, fontSize: 14)
        countLabel                  = GHFTitleLabel(textAlignment: .center, fontSize: 14)
    }

    private func addSubviews() {
        addSubview(symbolImageView)
        addSubview(titleLabel)
        addSubview(countLabel)
    }

    private func setupConstraints() {
        symbolImageView.pin(.top, to: self.top)
        symbolImageView.pin(.leading, to: self.leading)
        symbolImageView.square(20)

        titleLabel.centerY(in: symbolImageView)
        titleLabel.pin(.leading, to: symbolImageView.trailing, constant: 12)
        titleLabel.pin(.trailing, to: self.trailing)
        titleLabel.height(18)

        countLabel.pin(.top, to: symbolImageView.bottom, constant: 4)
        countLabel.pin(.leading, to: self.leading)
        countLabel.pin(.trailing, to: self.trailing)
        countLabel.height(18)
    }

    func set(itemType: ItemInfoType, withCount count: Int) {
        switch itemType {
        case .repos:
            symbolImageView.image   = SFSymbols.repos
            titleLabel.text         = "Public Repos"
        case .gists:
            symbolImageView.image   = SFSymbols.gists
            titleLabel.text         = "Public Gists"
        case .followers:
            symbolImageView.image   = SFSymbols.followers
            titleLabel.text         = "Followers"
        case .following:
            symbolImageView.image   = SFSymbols.following
            titleLabel.text         = "Following"
        }

        countLabel.text             = String(count)
    }

}
