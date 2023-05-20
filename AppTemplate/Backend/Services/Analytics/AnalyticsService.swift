//
//  AnalyticsService.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 2/18/23.
//

import Foundation

class AnalyticsService: AnalyticsServing {

    // MARK: - Properties
    var entityController: (any ModelControlling)?

    // MARK: - Initializers
    init() {
        self.entityController = EntityController<VariableSet>()
    }

    // MARK: - AnalyticsServing Functions
    func log(message: String, in function: String, date: Date) {
        NSLog("Message: \(message)")
        NSLog("Function: \(function)")
        NSLog("Date+Time: \(date)")
    }

    // MARK: - AnalyticsModelController Functions

    // MARK: - Helper Functions
}
