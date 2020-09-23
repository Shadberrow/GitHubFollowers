//
//  GHFAlertContainerView.swift
//  GHF
//
//  Created by Yevhenii on 08.05.2020.
//  Copyright © 2020 Yevhenii. All rights reserved.
//

import UIKit

class GHFAlertContainerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    private func setupView() {
        layer.cornerRadius    = 16
        layer.borderWidth     = 1
        layer.borderColor     = UIColor.white.cgColor
        backgroundColor       = .systemBackground

        setupSubviews()
        addSubviews()
        setupConstraints()
    }

    private func setupSubviews() {}

    private func addSubviews() {}

    private func setupConstraints() {}

}
