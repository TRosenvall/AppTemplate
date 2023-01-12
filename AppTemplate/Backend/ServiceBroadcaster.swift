//
//  ServiceBroadcaster.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 1/9/23.
//

import Foundation

protocol ServiceResolvingBroadcaster {
    var requiredServices: [UtilityType.Service] { get }
    var accessibleServices: [UtilityType.Service: any Service] { get async }
    func updateDependencies(from serviceResolver: ServiceResolving?) async
    func getService<T: Service>(ofType serviceType: UtilityType.Service) async -> T?
}

// Overridable Default Implementations
extension ServiceResolvingBroadcaster {
    nonisolated var requiredServices: [UtilityType.Service] {
        return [.DataRouting]
    }

    func getService<T: Service>(ofType serviceType: UtilityType.Service) async -> T? {
        return await accessibleServices[serviceType] as? T
    }
}
