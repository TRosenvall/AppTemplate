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
            print("100. Loading Data")
            var exceptions = await ServiceResolver.shared.configureServices()
            do {
                print("x00. Configuring Launch Entity Controller")
                try await self.entityController.configure()
            } catch {
                exceptions.append(error)
            }
            output.didFinishLoading()
        }
    }

    // MARK: - Helper Functions
}
