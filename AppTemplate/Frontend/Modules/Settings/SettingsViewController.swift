//
//  SettingsViewController.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/25/22.
//

import UIKit

class SettingsViewController: UIViewController, SettingsView {

    // MARK: - Properties
    let theme: SettingsTheme
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
        self.view.backgroundColor = theme.viewBackgroundColor
    }

    // MARK: - UIViewController Functions

    // MARK: - SettingsView Functions

    // MARK: - Helper Functions
}
