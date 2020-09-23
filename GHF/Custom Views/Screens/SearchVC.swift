//
//  SearchVC.swift
//  GHF
//
//  Created by Yevhenii on 24.03.2020.
//  Copyright © 2020 Yevhenii. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    private var logoImageView       : UIImageView!
    private var userNameTextField   : GHFTextField!
    private var callToActionButton  : GHFButton!

    private var logoImageViewTopAnchor: NSLayoutConstraint!

    var isUserNameEntered: Bool {
        guard let text = userNameTextField.text else { return false }
        return !text.isEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    private func setupView() {
        view.backgroundColor = .systemBackground

        createKeyboardDismissTapGesture()

        setupSubviews()
        addSubviews()
        setupConstraints()
    }

    private func setupSubviews() {
        logoImageView       = UIImageView()
        logoImageView.image = Images.ghLogo

        userNameTextField   = GHFTextField()
        userNameTextField.delegate = self

        callToActionButton  = GHFButton(backgroundColor: .systemGreen, title: "Get Followers")
        callToActionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
    }

    private func addSubviews() {
        view.addSubviews(logoImageView, userNameTextField, callToActionButton)
    }

    private func setupConstraints() {
        let logoSize    : CGFloat = DeviceType.isiPhoneSE || DeviceType.isiPhone8Zoomed ? 180 : 200
        let logoTopConst: CGFloat = DeviceType.isiPhoneSE || DeviceType.isiPhone8Zoomed ? 20 : 80

        logoImageViewTopAnchor = logoImageView.pin(.top, to: view.safeAreaLayoutGuide.topAnchor, constant: logoTopConst)
        logoImageView.centerX(in: view)
        logoImageView.square(logoSize)

        userNameTextField.pin(.top, to: logoImageView.bottom, constant: 48)
        userNameTextField.pin(.leading, to: view.leading, constant: 50)
        userNameTextField.pin(.trailing, to: view.trailing, constant: 50)
        userNameTextField.height(50)

        callToActionButton.pin(.bottom, to: view.safeAreaLayoutGuide.bottomAnchor, constant: 50)
        callToActionButton.pin(.leading, to: view.leading, constant: 50)
        callToActionButton.pin(.trailing, to: view.trailing, constant: 50)
        callToActionButton.height(50)
    }

    private func createKeyboardDismissTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }

    @objc
    private func pushFollowerListVC() {
        guard isUserNameEntered else {
            presentGHFAlretOnMainThread(title: "Empty Username", message: "Please enter a username. We need to know who to look for.", buttonTitle: "Ok")
            return
        }

        userNameTextField.resignFirstResponder()

        let vc = FollowerListVC(user: userNameTextField.text ?? "")
        navigationController?.pushViewController(vc, animated: true)

        userNameTextField.text = ""
    }

}


extension SearchVC: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListVC()
        return true
    }

}
