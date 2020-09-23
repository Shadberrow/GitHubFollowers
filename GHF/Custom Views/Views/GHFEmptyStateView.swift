//
//  GHFEmptyStateView.swift
//  GHF
//
//  Created by Yevhenii on 19.04.2020.
//  Copyright © 2020 Yevhenii. All rights reserved.
//

import UIKit

class GHFEmptyStateView: UIView {

    private let messageLabel = GHFTitleLabel(textAlignment: .center, fontSize: 28)
    private let imageView    = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    convenience init(message: String) {
        self.init(frame: .zero)
        messageLabel.text = message
    }

    private func setupView() {
        setupSubviews()
        addSubviews()
        setupConstraints()
    }

    private func setupSubviews() {
        messageLabel.numberOfLines  = 3
        messageLabel.textColor      = .secondaryLabel
        
        imageView.image             = Images.emptyStateLogo
    }

    private func addSubviews() {
        addSubview(messageLabel)
        addSubview(imageView)
    }

    private func setupConstraints() {
        let isSmallDevice                           = DeviceType.isiPhoneSE || DeviceType.isiPhone8Zoomed
        let messageLabelCenterYConstant: CGFloat    = isSmallDevice ? -80 : -150
        let imageViewBottomConstant: CGFloat        = isSmallDevice ? -80 : -40

        messageLabel.centerY(in: self, constant: messageLabelCenterYConstant)
        messageLabel.pin(.leading, to: self.leading, constant: 40)
        messageLabel.pin(.trailing, to: self.trailing, constant: 40)

        imageView.width(equalTo: self.width, multiplier: 1.3)
        imageView.height(equalTo: self.width, multiplier: 1.3)
        imageView.pin(.trailing, to: self.trailing, constant: -170)
        imageView.pin(.bottom, to: self.bottom, constant: imageViewBottomConstant)
    }

}
