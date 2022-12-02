//
//  HomeViewController.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/24/22.
//

import UIKit

class HomeViewController: UIViewController, HomeView {

    // MARK: - Properties
    var theme: HomeTheme
    var presenter: HomePresenting? = nil

    // MARK: - Initializers
    public init(theme: HomeTheme) {
        self.theme = theme
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("This class does not support NSCoder")
    }

    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.buildBarButtonItems()
    }

    // MARK: - UIViewController Functions

    // MARK: - HomeView Functions
    @objc func settingsBarButtonItemTapped() {
        presenter?.settingsButtonTapped()
    }

    @objc func placeholderBarButtonItemTapped() {}

    // MARK: - Helper Functions
    func buildBarButtonItems() {
        let settingsBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear.circle"),
                                                    style: .plain,
                                                    target: self,
                                                    action: #selector(settingsBarButtonItemTapped))

        let placeholderBarButtonItem = UIBarButtonItem(title: "",
                                                       style: .plain,
                                                       target: self,
                                                       action: #selector(placeholderBarButtonItemTapped))

        self.navigationItem.title = "Home"
        self.navigationItem.leftBarButtonItem = settingsBarButtonItem
        self.navigationItem.rightBarButtonItem = placeholderBarButtonItem
    }
}
