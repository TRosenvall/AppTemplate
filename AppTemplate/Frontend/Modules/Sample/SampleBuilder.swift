//
//  SampleBuilder.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/24/22.
//

class SampleBuilder: SampleBuilding {

    // MARK: - Properties
    typealias ModuleType = SampleView

    let appTheme: AppTheme
    let serviceResolver: ServiceResolving
    let moduleResolver: ModuleResolving

    // MARK: - Initializers
    init(appTheme: AppTheme,
         serviceResolver: ServiceResolving,
         moduleResolver: ModuleResolving) {
        self.appTheme = appTheme
        self.serviceResolver = serviceResolver
        self.moduleResolver = moduleResolver
    }

    // MARK: - SampleBuilding Functions
    func buildModule() -> SampleView {
        // Get needed properties
        let sampleTheme = SampleTheme(base: appTheme)
        let persistenceService = serviceResolver.services.persistence

        // Build module parts
        let entity = SampleEntity(persistenceService: persistenceService)
        let view = SampleViewController(theme: sampleTheme)
        let presenter = SamplePresenter(view: view)
        let interactor = SampleInteractor(entity: entity,
                                          output: presenter as SampleOutput)
        let router = SampleRouter(presentingView: view,
                                  moduleResolver: moduleResolver)

        // Set the missing parts where needed
        presenter.interactor = interactor
        presenter.router = router
        view.presenter = presenter

        // Return the view
        return view
    }

    // MARK: - Helper Functions
}
