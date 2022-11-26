//
//  HomeViewController.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/24/22.
//

import UIKit

class HomeViewController: UIViewController, HomeView {

    // MARK: - Properties
    let theme: HomeTheme
    var constraints: HomeConstraints? = nil
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
    }

    // MARK: - UIViewController Functions

    // MARK: - HomeView Functions

    // MARK: - Helper Functions
}
