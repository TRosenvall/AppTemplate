//
//  SamplePresenter.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/24/22.
//

class SamplePresenter: SamplePresenting, SampleOutput {
    
    // MARK: - Properties
    var view: SampleView
    var router: SampleWireframe? = nil
    var interactor: SampleInput? = nil

    // MARK: - Initializers
    init(view: SampleView) {
        self.view = view
    }

    // MARK: - SamplePresenting Functions

    // MARK: - SampleOutput Functions

    // MARK: - Helper Functions
}
