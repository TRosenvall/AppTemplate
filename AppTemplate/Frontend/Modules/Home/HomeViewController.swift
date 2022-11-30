//
//  HomeViewController.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/24/22.
//

import UIKit

class HomeViewController: UIViewController, HomeView {

    // MARK: - Properties
    var constraints: HomeConstraining? = nil
    var presenter: HomePresenting? = nil

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

    // MARK: - HomeView Functions
    func settingsBarButtonItemTapped() {
        presenter?.settingsButtonTapped()
    }

    func placeholderBarButtonItemTapped() {}

    // MARK: - Helper Functions
}
