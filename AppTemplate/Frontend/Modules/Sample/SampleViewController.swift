//
//  SampleViewController.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/24/22.
//

import UIKit

class SampleViewController: UIViewController, SampleView {

    // MARK: - Properties
    let theme: SampleTheme
    var presenter: SamplePresenting? = nil

    // MARK: - Initializers
    public init(theme: SampleTheme) {
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

    // MARK: - SampleView Functions

    // MARK: - Helper Functions
}
