//
//  UIHelper.swift
//  GHF
//
//  Created by Yevhenii on 15.04.2020.
//  Copyright © 2020 Yevhenii. All rights reserved.
//

import UIKit

enum UIHelper {

    static func createThreeColumnFlowLayout(in rect: CGRect) -> UICollectionViewFlowLayout {

        let width                           = rect.width
        let padding: CGFloat                = 12
        let minimumItemSpacing: CGFloat     = 10
        let availableWidth                  = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth                       = availableWidth / 3

        let collectionFlowLayout            = UICollectionViewFlowLayout()
        collectionFlowLayout.sectionInset   = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        collectionFlowLayout.itemSize       = CGSize(width: itemWidth, height: itemWidth + 40)

        return collectionFlowLayout
    }

}
