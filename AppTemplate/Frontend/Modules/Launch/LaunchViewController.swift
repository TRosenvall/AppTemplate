//
//  LaunchViewController.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/25/22.
//

import UIKit

class LaunchViewController: UIViewController, LaunchView {

    // MARK: - Properties
    var constraints: LaunchConstraints? = nil
    var presenter: LaunchPresenting? = nil

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
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.viewDidAppear()
    }

    // MARK: - UIViewController Functions

    // MARK: - LaunchView Functions

    // MARK: - Helper Functions
}
