//
//  GHFBodyLabel.swift
//  GHF
//
//  Created by Yevhenii on 01.04.2020.
//  Copyright © 2020 Yevhenii. All rights reserved.
//

import UIKit

class GHFBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    convenience init(textAlignment: NSTextAlignment) {
        self.init(frame: .zero)
        
        self.textAlignment = textAlignment
    }

    private func setupView() {
        font                                = UIFont.preferredFont(forTextStyle: .body)
        textColor                           = .secondaryLabel
        adjustsFontSizeToFitWidth           = true
        adjustsFontForContentSizeCategory   = true
        minimumScaleFactor                  = 0.75
        lineBreakMode                       = .byWordWrapping
    }

}
