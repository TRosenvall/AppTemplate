//
//  HomeViewController.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/24/22.
//

import UIKit

class HomeViewController: UIViewController, HomeView {

    // MARK: - Properties
    var constraints: HomeConstraints? = nil
    var presenter: HomePresenting? = nil

    // MARK: - Interactables - Anything that requires a `#selector()` should go here.
    lazy var settingsBarButtonItem: UIBarButtonItem = UIBarButtonItem(
        image: UIImage(systemName: "gear.circle"),
        style: .plain,
        target: self,
        action: #selector(settingsButtonTapped(sender:))
    )
    lazy var placeholderBarButtonItem: UIBarButtonItem = UIBarButtonItem(
        title: "",
        style: .plain,
        target: self,
        action: #selector(settingsButtonTapped(sender:))
    )

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

    // MARK: - HomeView Functions
    @objc func settingsButtonTapped(sender: UIBarButtonItem) {
        print("Testing")
    }

    @objc func placeholderBarButtonItem(sender: UIBarButtonItem) {}

    // MARK: - Helper Functions
}