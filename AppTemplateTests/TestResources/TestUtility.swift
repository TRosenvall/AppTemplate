//
//  TestUtility.swift
//  AppTemplateTests
//
//  Created by Timothy Rosenvall on 11/24/22.
//

@testable import AppTemplate

class TestUtility {

    // MARK: - Resolvers
    lazy var serviceResolver:
    lazy var moduleResolver:

    // MARK: - Themes
    lazy var appTheme: AppTheme = AppTheme()
    lazy var sampleTheme: SampleTheme = SampleTheme(base: appTheme)

    // MARK: - Initializer
    init() {}
}
