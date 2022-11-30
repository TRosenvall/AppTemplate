//
//  HomeConstraints.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/25/22.
//

import UIKit

class HomeConstraints: HomeConstraining {

    // MARK: - Properties
    var theme: HomeTheme
    var viewController: HomeView
    lazy var views: (settingsBarButtonItem: UIBarButtonItem,
                     placeholderBarButtonItem: UIBarButtonItem,
                     rootView: UIView,
                     navBarView: UIView,
                     logoImageView: UIImageView) = (settingsBarButtonItem: UIBarButtonItem(),
                                                    placeholderBarButtonItem: UIBarButtonItem(),
                                                    rootView: UIView(),
                                                    navBarView: UIView(),
                                                    logoImageView: UIImageView())

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

    // LogoImageView Constraints
    lazy var defaultLogoImageViewCenterYAnchor = views.logoImageView.centerYAnchor.constraint(
        equalTo: views.rootView.safeAreaLayoutGuide.centerYAnchor,
        constant: -11
    )
    lazy var defaultLogoImageViewHeightAnchor = views.logoImageView.heightAnchor.constraint(
        equalTo: views.logoImageView.widthAnchor
    )
    lazy var defaultLogoImageViewLeadingAnchor = views.logoImageView.leadingAnchor.constraint(
        equalTo: views.rootView.leadingAnchor,
        constant: 11
    )
    lazy var defaultLogoImageViewTrailingAnchor = views.logoImageView.trailingAnchor.constraint(
        equalTo: views.rootView.trailingAnchor,
        constant: -11
    )

    // MARK: - Initializers
    init(theme: HomeTheme,
         viewController: HomeView) {
        self.theme = theme
        self.viewController = viewController
    }

    // MARK: - HomeConstraining Functions
    func build() {
        // Create remaining Views
        buildViews(on: viewController.view)

        // Constrain Views
        NSLayoutConstraint.activate([defaultNavBarViewTopAnchor,
                                     defaultNavBarViewBottomAnchor,
                                     defaultNavBarViewLeadingAnchor,
                                     defaultNavBarViewTrailingAnchor,

                                     defaultLogoImageViewCenterYAnchor,
                                     defaultLogoImageViewHeightAnchor,
                                     defaultLogoImageViewLeadingAnchor,
                                     defaultLogoImageViewTrailingAnchor])

        // Set Navigation Items
        viewController.navigationItem.title = "Home"
        viewController.navigationItem.leftBarButtonItem = views.settingsBarButtonItem
        viewController.navigationItem.rightBarButtonItem = views.placeholderBarButtonItem
    }

    // MARK: - Objc Wrappers for View controller actions.
    @objc func settingsBarButtonItemAction() {
        viewController.settingsBarButtonItemTapped()
    }

    @objc func placeholderBarButtonItemAction() {
        viewController.placeholderBarButtonItemTapped()
    }

    // MARK: - Helper Functions

    private func buildViews(on rootView: UIView) {
        // UINavigationController Views
        let settingsBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear.circle"),
                                                    style: .plain,
                                                    target: self,
                                                    action: #selector(settingsBarButtonItemAction))

        let placeholderBarButtonItem = UIBarButtonItem(title: "",
                                                       style: .plain,
                                                       target: self,
                                                       action: #selector(placeholderBarButtonItemAction))

        // RootView
        rootView.backgroundColor = theme.viewBackgroundColor

        // NavBarView to go underneath the existing UINavigationBar
        let navBarView = UIView()
        navBarView.backgroundColor = theme.navBarViewColor
        navBarView.translatesAutoresizingMaskIntoConstraints = false
        rootView.addSubview(navBarView)

        // LogoImageView to put the app logo on the screen
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "AppLogo")
        logoImageView.alpha = 0.44
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        rootView.addSubview(logoImageView)

        self.views = (settingsBarButtonItem: settingsBarButtonItem,
                      placeholderBarButtonItem: placeholderBarButtonItem,
                      rootView: rootView,
                      navBarView: navBarView,
                      logoImageView: logoImageView)
    }
}
