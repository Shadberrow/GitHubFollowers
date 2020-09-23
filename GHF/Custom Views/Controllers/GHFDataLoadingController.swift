//
//  GHFDataLoadingController.swift
//  GHF
//
//  Created by Yevhenii on 08.05.2020.
//  Copyright © 2020 Yevhenii. All rights reserved.
//

import UIKit

class GHFDataLoadingController: UIViewController {

    private var containerView: UIView!

    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)

        containerView.backgroundColor   = .systemBackground
        containerView.alpha             = 0

        UIView.animate(withDuration: 0.25, animations: { self.containerView.alpha = 0.8 })

        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)

        activityIndicator.centered(in: containerView)

        activityIndicator.startAnimating()
    }

    func dismissLoadingView() {
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }

    func showEmptyStateView(with message: String, in view: UIView) {
        let emptyStateView = GHFEmptyStateView(message: message)
        view.addSubview(emptyStateView)
        emptyStateView.fill(in: view)
    }

    func removeEmptyStateView() {
        view.subviews.forEach({
            if $0 is GHFEmptyStateView {
                $0.subviews.forEach({ $0.removeFromSuperview() })
                $0.removeFromSuperview()
            }
        })
    }


}
