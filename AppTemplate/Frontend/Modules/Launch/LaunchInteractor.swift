//
//  LaunchInteractor.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/25/22.
//

class LaunchInteractor: LaunchInput {

    // MARK: - Properties
    let entityController: any ModelControlling
    let output: LaunchOutput

    // MARK: - Initializers
    init(entityController: any ModelControlling,
         output: LaunchOutput) {
        self.entityController = entityController
        self.output = output
    }

    // MARK: - LaunchInput Functions
    func launch() {
        Task {
            await ServiceResolver.shared.configureServices()
            output.didFinishLoading()
        }
    }

    // MARK: - Helper Functions
    private func loadKeyServices() async {
        
    }

    private func loadAdditionalSerivces() async {
        
    }

    private func loadModules() async {
        
    }

    private func unloadInactiveServices() async {
        
    }
}
