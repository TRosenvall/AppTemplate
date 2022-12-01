//
//  LaunchConstraints.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/25/22.
//

import UIKit

class LaunchConstraints: LaunchConstraining {

    // MARK: - Properties
    var theme: LaunchTheme
    var viewController: LaunchView

    lazy var views: (rootView: UIView,
                     logoImageView: UIImageView) = (rootView: UIView(),
                                                    logoImageView: UIImageView())

    // MARK: - Constraints
    // LogoImageView Constraints
    lazy var defaultLogoImageViewCenterYAnchor = views.logoImageView.centerYAnchor.constraint(
        equalTo: views.rootView.safeAreaLayoutGuide.centerYAnchor
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
    init(theme: LaunchTheme,
         viewController: LaunchView) {
        self.theme = theme
        self.viewController = viewController
    }

    // MARK: - LaunchConstraining Functions
    func build() {
        // Create remaining Views
        buildViews(on: viewController.view)

        // Constrain Views
        NSLayoutConstraint.activate([defaultLogoImageViewCenterYAnchor,
                                     defaultLogoImageViewHeightAnchor,
                                     defaultLogoImageViewLeadingAnchor,
                                     defaultLogoImageViewTrailingAnchor])
    }

    // MARK: - Helper Functions
    private func buildViews(on rootView: UIView) {
        // RootView
        rootView.backgroundColor = theme.viewBackgroundColor

        // LogoImageView to put the app logo on the screen
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "AppLogo")
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        rootView.addSubview(logoImageView)

        self.views = (rootView: rootView,
                      logoImageView: logoImageView)
    }
}
