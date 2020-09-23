//
//  UIView+Ext.swift
//  GHF
//
//  Created by Yevhenii on 09.05.2020.
//  Copyright © 2020 Yevhenii. All rights reserved.
//

import UIKit

extension UIView {

    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }

}
