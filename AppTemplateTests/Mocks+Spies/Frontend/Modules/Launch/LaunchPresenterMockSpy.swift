//
//  LaunchPresenterMockSpy.swift
//  AppTemplateTests
//
//  Created by Timothy Rosenvall on 11/26/22.
//

@testable import AppTemplate

class LaunchPresenterMockSpy: LaunchPresenting, LaunchOutput {

    var viewDidAppearCallCount = 0
    func viewDidAppear() {
        viewDidAppearCallCount += 1
    }
}
