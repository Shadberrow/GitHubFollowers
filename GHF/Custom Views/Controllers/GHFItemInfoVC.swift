//
//  GHFItemInfoVC.swift
//  GHF
//
//  Created by Yevhenii on 05.05.2020.
//  Copyright © 2020 Yevhenii. All rights reserved.
//

import UIKit

class GHFItemInfoVC: UIViewController {

    private var stackView       : UIStackView!
    public var itemInfoViewOne  : GHFItemInfoView!
    public var itemInfoViewTwo  : GHFItemInfoView!
    public var actionButton     : GHFButton!

    var user: User!

    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.backgroundColor    = .secondarySystemBackground
        view.layer.cornerRadius = 18


        setupSubviews()
        addSubviews()
        setupConstraints()
    }

    private func setupSubviews() {
        itemInfoViewOne         = GHFItemInfoView()
        itemInfoViewTwo         = GHFItemInfoView()
        actionButton            = GHFButton()

        stackView               = UIStackView()
        stackView.axis          = .horizontal
        stackView.distribution  = .equalSpacing
        stackView.addArrangedSubview(itemInfoViewOne)
        stackView.addArrangedSubview(itemInfoViewTwo)

        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }

    private func addSubviews() {
        view.addSubview(stackView)
        view.addSubview(actionButton)
    }

    private func setupConstraints() {
        let padding: CGFloat = 20

        stackView.pin(.top,      to: view.top,      constant: padding)
        stackView.pin(.leading,  to: view.leading,  constant: padding)
        stackView.pin(.trailing, to: view.trailing, constant: padding)
        stackView.height(50)

        actionButton.pin(.bottom,   to: view.bottom,   constant: padding)
        actionButton.pin(.leading,  to: view.leading,  constant: padding)
        actionButton.pin(.trailing, to: view.trailing, constant: padding)
        actionButton.height(44)
    }

    @objc
    public func actionButtonTapped() {}

}
