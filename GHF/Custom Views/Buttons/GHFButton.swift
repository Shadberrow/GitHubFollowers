//
//  GHFButton.swift
//  GHF
//
//  Created by Yevhenii on 24.03.2020.
//  Copyright © 2020 Yevhenii. All rights reserved.
//

import UIKit

class GHFButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    convenience init(backgroundColor: UIColor, title: String) {
        self.init(frame: .zero)

        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
    }

    private func setupView() {
        setTitleColor(.white, for: .normal)
        layer.cornerRadius      = 10
        titleLabel?.font        = UIFont.preferredFont(forTextStyle: .headline)
    }

    func set(backgroundColor: UIColor, title: String) {
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
    }

}
