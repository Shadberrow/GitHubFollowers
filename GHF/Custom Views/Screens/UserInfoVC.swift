//
//  UserInfoVC.swift
//  GHF
//
//  Created by Yevhenii on 19.04.2020.
//  Copyright © 2020 Yevhenii. All rights reserved.
//

import UIKit

protocol UserInfoVCDelegate: class {
    func didRequestFollowers(for username: String)
}

class UserInfoVC: UIViewController {

    private var doneBarButtonItem: UIBarButtonItem!

    private let scrollView  = UIScrollView()
    private let contentView = UIView()
    private let headerView  = UIView()
    private let itemViewOne = UIView()
    private let itemViewTwo = UIView()
    private let dateLabel   = GHFBodyLabel(textAlignment: .center)

    var userName: String!
    weak var delegate: UserInfoVCDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getUserInfo()
    }

    private func setupView() {
        view.backgroundColor = .systemBackground

        setupSubviews()
        addSubviews()
        setupConstraints()
    }

    private func setupSubviews() {
        doneBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDone))
    }

    private func addSubviews() {
        navigationItem.rightBarButtonItem = doneBarButtonItem

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(headerView)
        contentView.addSubview(itemViewOne)
        contentView.addSubview(itemViewTwo)
        contentView.addSubview(dateLabel)
    }

    private func setupConstraints() {
        let padding     : CGFloat = 20
        let itemHeight  : CGFloat = 140

        scrollView.fill(in: view)

        contentView.fill(in: scrollView)
        contentView.width(equalTo: scrollView.width)
        contentView.height(600)


        headerView.pin(.top, to: contentView.top)
        headerView.pin(.leading, to: contentView.leading, constant: padding)
        headerView.pin(.trailing, to: contentView.trailing, constant: padding)
        headerView.height(210)

        itemViewOne.pin(.top, to: headerView.bottom, constant: padding)
        itemViewOne.pin(.leading, to: headerView.leading)
        itemViewOne.pin(.trailing, to: headerView.trailing)
        itemViewOne.height(itemHeight)

        itemViewTwo.pin(.top, to: itemViewOne.bottom, constant: padding)
        itemViewTwo.pin(.leading, to: headerView.leading)
        itemViewTwo.pin(.trailing, to: headerView.trailing)
        itemViewTwo.height(itemHeight)

        dateLabel.pin(.top, to: itemViewTwo.bottom, constant: padding)
        dateLabel.pin(.leading, to: headerView.leading)
        dateLabel.pin(.trailing, to: headerView.trailing)
    }

    @objc
    private func handleDone() {
        dismiss(animated: true)
    }

    private func add(childViewController child: UIViewController, toContainerView container: UIView) {
        addChild(child)
        container.addSubview(child.view)
        child.view.frame = container.bounds
        child.didMove(toParent: self)
    }

    private func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: userName) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(user):
                DispatchQueue.main.async { self.configureUIElements(with: user) }
            case let .failure(error):
                self.presentGHFAlretOnMainThread(title: "Something went wrong", message: error.localizedDescription, buttonTitle: "Ok")
            }
        }
    }

    private func configureUIElements(with user: User) {
        let itemHeader          = GHFUserInfoHeaderVC(user: user)
        let itemRepos           = GHFRepoItemVC(user: user)
        itemRepos.delegate      = self
        let itemFollowers       = GHFFollowerItemVC(user: user)
        itemFollowers.delegate  = self


        self.add(childViewController: itemHeader,
                 toContainerView: self.headerView)
        self.add(childViewController: itemRepos,
                 toContainerView: self.itemViewOne)
        self.add(childViewController: itemFollowers,
                 toContainerView: self.itemViewTwo)
        self.dateLabel.text = "GitHub since " + user.createdAt.toMonthYearFormat()
    }

}

extension UserInfoVC: GHFFollowerItemVCDelegate {

    func didTapFollowers(for user: User) {
        guard user.followers != 0 else {
            presentGHFAlretOnMainThread(title: "No Followers", message: "This user has no followers 😢", buttonTitle: "So Sad")
            return
        }

        dismiss(animated: true)
        delegate?.didRequestFollowers(for: user.login)
    }

}


extension UserInfoVC: GHFRepoItemVCDelegate {

    func didTapGiHubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGHFAlretOnMainThread(title: "Invalid URL", message: "The url attached to this user is invalid", buttonTitle: "Ok")
            return
        }

        presentSafariVC(with: url)
    }

}
