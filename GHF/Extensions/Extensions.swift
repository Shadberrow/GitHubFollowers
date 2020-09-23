//
//  Extensions.swift
//  GHF
//
//  Created by Yevhenii on 07.04.2020.
//  Copyright © 2020 Yevhenii. All rights reserved.
//

import UIKit

protocol ReusableTypeCell {

    static var reuseIdentifier: String { get }

}

extension UITableViewCell: ReusableTypeCell {

    static var reuseIdentifier: String {
        String(describing: self)
    }

}

extension UICollectionViewCell: ReusableTypeCell {

    static var reuseIdentifier: String {
        String(describing: self)
    }

}
