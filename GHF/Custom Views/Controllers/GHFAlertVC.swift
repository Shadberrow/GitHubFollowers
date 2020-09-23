//
//  GHFAlertVC.swift
//  GHF
//
//  Created by Yevhenii on 01.04.2020.
//  Copyright © 2020 Yevhenii. All rights reserved.
//

import UIKit

class GHFAlertVC: UIViewController {

    private let containerView   = GHFAlertContainerView()
    private let titleLabel      = GHFTitleLabel(textAlignment: .center, fontSize: 20)
    private let messageLabel    = GHFBodyLabel(textAlignment: .center)
    private let actionButton    = GHFButton(backgroundColor: .systemPink, title: "Ok")

    private var alertTitle      : String?
    private var message         : String?
    private var buttonTitle     : String?

    let padding         : CGFloat = 20

    init(title: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)

        self.alertTitle     = title
        self.message        = message
        self.buttonTitle    = buttonTitle
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)

        setupSubviews()
        addSubviews()
        setupConstraints()
    }

    private func setupSubviews() {
        // Configure title label
        titleLabel.text            = alertTitle ?? "Oops =("

        // Configure message label
        messageLabel.text          = message ?? "Unable to send a request"
        messageLabel.numberOfLines = 4

        // Configure action button
        actionButton.setTitle(buttonTitle ?? "Ok", for: .normal)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
    }

    private func addSubviews() {
        view.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(messageLabel)
        containerView.addSubview(actionButton)
    }

    private func setupConstraints() {
        // Configure container view constraints
        containerView.centered(in: view)
        containerView.size(width: 280, height: 220)

        // Configure title label constraints
        titleLabel.pin(.top, to: containerView.top, constant: padding)
        titleLabel.pin(.leading, to: containerView.leading, constant: padding)
        titleLabel.pin(.trailing, to: containerView.trailing, constant: padding)
        titleLabel.height(28)

        // Configure message label
        messageLabel.pin(.top, to: titleLabel.bottom, constant: 8)
        messageLabel.pin(.bottom, to: actionButton.top, constant: 12)
        messageLabel.pin(.leading, to: containerView.leading, constant: padding)
        messageLabel.pin(.trailing, to: containerView.trailing, constant: padding)

        // Configure action button constraints
        actionButton.pin(.bottom, to: containerView.bottom, constant: padding)
        actionButton.pin(.leading, to: containerView.leading, constant: padding)
        actionButton.pin(.trailing, to: containerView.trailing, constant: padding)
        actionButton.height(44)
    }

    @objc
    private func dismissVC() {
        dismiss(animated: true)
    }

}
