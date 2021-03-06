//
//  UIViewController+Ext.swift
//  GHF
//
//  Created by Yevhenii on 01.04.2020.
//  Copyright © 2020 Yevhenii. All rights reserved.
//

import UIKit
import SafariServices

extension UIViewController {

    func presentGHFAlretOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = GHFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }

    func presentSafariVC(with url: URL) {
        let vc = SFSafariViewController(url: url)
        vc.preferredControlTintColor = .systemGreen
        present(vc, animated: true)
    }

}
