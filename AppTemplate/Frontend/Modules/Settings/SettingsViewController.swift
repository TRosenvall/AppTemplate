//
//  SettingsViewController.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/25/22.
//

import UIKit

class SettingsViewController: UIViewController, SettingsView {

    // MARK: - Properties
    var theme: SettingsTheme
    var presenter: SettingsPresenting? = nil

    // MARK: - Initializers
    public init(theme: SettingsTheme) {
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

    // MARK: - SettingsView Functions
    @objc func backBarButtonItemTapped() {
        presenter?.backButtonTapped()
    }

    @objc func placeholderBarButtonItemTapped() {
        // no-op
    }

    // MARK: - Helper Functions
    func buildBarButtonItems() {
        let placeholderBarButtonItem = UIBarButtonItem(title: "",
                                                       style: .plain,
                                                       target: self,
                                                       action: #selector(placeholderBarButtonItemTapped))

        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(systemName: "chevron.right"),
                            for: .normal)
        backButton.setTitle("Back",
                            for: .normal)
        backButton.semanticContentAttribute = .forceRightToLeft
        backButton.sizeToFit()
        backButton.addTarget(self,
                             action: #selector(backBarButtonItemTapped),
                             for: .touchUpInside)
        let backBarButtonItem = UIBarButtonItem(customView: backButton)

        self.navigationItem.title = "Settings"
        self.navigationItem.leftBarButtonItem = placeholderBarButtonItem
        self.navigationItem.rightBarButtonItem = backBarButtonItem
    }
}
