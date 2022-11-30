//
//  SettingsConstraints.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/25/22.
//

import UIKit

class SettingsConstraints: SettingsConstraining {

    // MARK: - Properties
    var theme: SettingsTheme
    var viewController: SettingsView
    lazy var views: (placeholderBarButtonItem: UIBarButtonItem,
                     backBarButtonItem: UIBarButtonItem,
                     rootView: UIView,
                     navBarView: UIView) = (placeholderBarButtonItem: UIBarButtonItem(),
                                            backBarButtonItem: UIBarButtonItem(),
                                            rootView: UIView(),
                                            navBarView: UIView())

    // MARK: - Constraints
    // NavBarView Constraints
    lazy var defaultNavBarViewTopAnchor = views.navBarView.topAnchor.constraint(
        equalTo: views.rootView.topAnchor
    )
    lazy var defaultNavBarViewBottomAnchor = views.navBarView.bottomAnchor.constraint(
        equalTo: views.rootView.safeAreaLayoutGuide.topAnchor
    )
    lazy var defaultNavBarViewLeadingAnchor = views.navBarView.leadingAnchor.constraint(
        equalTo: views.rootView.leadingAnchor
    )
    lazy var defaultNavBarViewTrailingAnchor = views.navBarView.trailingAnchor.constraint(
        equalTo: views.rootView.trailingAnchor
    )

    // MARK: - Initializers
    init(theme: SettingsTheme,
         viewController: SettingsView) {
        self.theme = theme
        self.viewController = viewController
    }

    // MARK: - SettingsConstraining Functions
    func build() {
        // Create remaining Views
        buildViews(on: viewController.view)

        // Constrain Views
        NSLayoutConstraint.activate([defaultNavBarViewTopAnchor,
                                    defaultNavBarViewBottomAnchor,
                                    defaultNavBarViewLeadingAnchor,
                                    defaultNavBarViewTrailingAnchor])

        // Set Navigation Items
        viewController.navigationItem.title = "Settings"
        viewController.navigationItem.leftBarButtonItem = views.placeholderBarButtonItem
        viewController.navigationItem.rightBarButtonItem = views.backBarButtonItem
    }

    // MARK: - Objc Wrappers for View controller actions.
    @objc func backBarButtonItemAction() {
        viewController.backBarButtonItemTapped()
    }

    @objc func placeholderBarButtonItemAction() {
        viewController.placeholderBarButtonItemTapped()
    }

    // MARK: - Helper Functions
    private func buildViews(on rootView: UIView) {
        // UINavigationController Views
        let placeholderBarButtonItem = UIBarButtonItem(title: "",
                                                       style: .plain,
                                                       target: self,
                                                       action: #selector(placeholderBarButtonItemAction))

        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(systemName: "chevron.right"),
                            for: .normal)
        backButton.setTitle("Back",
                            for: .normal)
        backButton.semanticContentAttribute = .forceRightToLeft
        backButton.sizeToFit()
        backButton.addTarget(self,
                             action: #selector(backBarButtonItemAction),
                             for: .touchUpInside)
        let backBarButtonItem = UIBarButtonItem(customView: backButton)

        // RootView
        rootView.backgroundColor = theme.viewBackgroundColor

        // NavBarView to go underneath the existing UINavigationBar
        let navBarView = UIView()
        navBarView.backgroundColor = theme.navBarViewColor
        navBarView.translatesAutoresizingMaskIntoConstraints = false
        rootView.addSubview(navBarView)

        self.views = (placeholderBarButtonItem: placeholderBarButtonItem,
                      backBarButtonItem: backBarButtonItem,
                      rootView: rootView,
                      navBarView: navBarView)
    }
}
