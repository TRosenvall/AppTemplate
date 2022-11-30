//
//  SettingsViewController.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/25/22.
//

import UIKit

class SettingsViewController: UIViewController, SettingsView {

    // MARK: - Properties
    var constraints: SettingsConstraining? = nil
    var presenter: SettingsPresenting? = nil

    // MARK: - Initializers
    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("This class does not support NSCoder")
    }

    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.constraints?.build()
    }

    // MARK: - UIViewController Functions

    // MARK: - SettingsView Functions
    func backBarButtonItemTapped() {
        presenter?.backButtonTapped()
    }

    func placeholderBarButtonItemTapped() {
        // no-op
    }

    // MARK: - Helper Functions
}
