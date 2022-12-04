//
//  SettingsViewController.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/25/22.
//

import UIKit

class SettingsViewController: UIViewController, SettingsView {

    // MARK: - Properties
    var theme: SettingsTheme
    var presenter: SettingsPresenting? = nil

    @IBOutlet var settingsTableView: UITableView!
    lazy var numberOfCells: Int = 10
    var rowHeight: CGFloat = 40
    
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
        self.buildBarButtonItems()
        self.buildTableView()
    }

    // MARK: - UIViewController Functions

    // MARK: - SettingsView Functions
    @objc func backBarButtonItemTapped() {
        presenter?.backButtonTapped()
    }

    @objc func placeholderBarButtonItemTapped() {
        // no-op
    }

    // MARK: - Helper Functions
    func buildBarButtonItems() {
        let placeholderBarButtonItem = UIBarButtonItem(title: "",
                                                       style: .plain,
                                                       target: self,
                                                       action: #selector(placeholderBarButtonItemTapped))

        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(systemName: "chevron.right"),
                            for: .normal)
        backButton.setTitle("Back",
                            for: .normal)
        backButton.semanticContentAttribute = .forceRightToLeft
        backButton.sizeToFit()
        backButton.addTarget(self,
                             action: #selector(backBarButtonItemTapped),
                             for: .touchUpInside)
        let backBarButtonItem = UIBarButtonItem(customView: backButton)

        self.navigationItem.title = "Settings"
        self.navigationItem.leftBarButtonItem = placeholderBarButtonItem
        self.navigationItem.rightBarButtonItem = backBarButtonItem
    }

    func buildTableView() {
        self.settingsTableView.delegate = self
        self.settingsTableView.dataSource = self
        self.settingsTableView.register(UINib(nibName: "SettingsTableViewCell",
                                              bundle: nil),
                                        forCellReuseIdentifier: "SettingsTableViewCell")

        self.settingsTableView.backgroundView?.backgroundColor = .clear
        self.settingsTableView.backgroundColor = .clear
        if rowHeight * CGFloat(numberOfCells) < self.settingsTableView.frame.height {
            self.settingsTableView.isScrollEnabled = false
        }
    }
    var number = 1
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - UITableViewDelegate Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfCells
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell",
                                                       for: indexPath) as? SettingsTableViewCell
        else {
            return UITableViewCell()
        }

        cell.selectionStyle = .none
        cell.titleTextLabel.text = "\(number)"

        cell.backgroundColor = theme.navBarViewColor?.withAlphaComponent(0.4)
        number += 1

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
}
