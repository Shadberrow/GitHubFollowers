//
//  GHFTitleLabel.swift
//  GHF
//
//  Created by Yevhenii on 01.04.2020.
//  Copyright © 2020 Yevhenii. All rights reserved.
//

import UIKit

class GHFTitleLabel: UILabel {

    init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        setupView()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    private func setupView() {
        textColor                   = .label
        adjustsFontSizeToFitWidth   = true
        minimumScaleFactor          = 0.7
        lineBreakMode               = .byTruncatingTail
    }

}
