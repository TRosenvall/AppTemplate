//
//  SettingsViewController.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/25/22.
//

import UIKit

class SettingsViewController: UIViewController, SettingsView {

    // MARK: - Properties
    var constraints: SettingsConstraints? = nil
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
        DispatchQueue.main.async {
            self.constraints?.build()
        }
    }

    // MARK: - UIViewController Functions

    // MARK: - SettingsView Functions

    // MARK: - Helper Functions
}
