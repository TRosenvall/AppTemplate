//
//  NetworkingService.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/24/22.
//

import Foundation

class NetworkingService: NetworkingServing {

    // MARK: - Properties
    var isOn: Bool = false

    // MARK: - Initializers
    init() {}

    // MARK: - PersistenceServing Functions
    func toggleState() {
        isOn = !isOn
    }

    // MARK: - Helper Functions
}
