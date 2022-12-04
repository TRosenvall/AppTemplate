//
//  ActiveDatastore.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 12/3/22.
//

import Foundation

class ActiveDatastore {

    let serviceResolver: ServiceResolving
    let moduleResolver: ModuleResolving

    init(serviceResolver: ServiceResolving,
         moduleResolver: ModuleResolving) {
        self.serviceResolver = serviceResolver
        self.moduleResolver = moduleResolver
    }

    struct BackendData {}
    struct FrontendData {
        struct LaunchData {}
        struct SettingsData {}
        struct HomeData {}
    }
}
