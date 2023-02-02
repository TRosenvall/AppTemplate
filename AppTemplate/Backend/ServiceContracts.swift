//
//  ServiceContracts.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/24/22.
//

import Foundation

/// `Persistence` - This service is used to send and retrieve data, either to the device or to the cloud
/// `Coding` - This service is used to encode and decode data
/// `Encryption` - This service is used to encrypt and decrypt data
/// `DataRouting` - This service is used to ensure data is being properly directed and ensures that each utility has
/// it's entity when needed.
/// `Networking` - This service is used to route all network calls if needed and return either the needed data or errors
/// `Authentication` - TODO - This service is used to authenticate any user with the app's web authentication
/// `DataExpiration` - TODO - This service is used to expire data after an amount of time. Such as retiring login tokens.

///------

protocol Service {
    var entityController: (any ModelControlling)? { get set }
}

///------

/// This delegate is used by the settings module to modify the state of the service.
protocol ToggleServiceDelegate: Actor {
    func toggle(service: UtilityType.Service, to state: Bool) async throws
}

protocol ServiceResolving: Actor, ToggleServiceDelegate {
    /// A singleton instance to provide global access to the `ServiceResolving` instance.
    static var shared: ServiceResolving { get }

    /// A list of all services in the active state.
    var activeServices: [UtilityType.Service: Service] { get set }

    /// Needs to be run in order to initialize the services within the service resolver.
    func configureServices() async -> [Error]

    /// Used to resolve a copy of an individual service from the activeServices list.
    func resolveService(ofType serviceType: UtilityType.Service) -> (any Service)?
}

///------

protocol ServicesRequiring {

    /// Put any required services here. Otherwise, these services won't be accessible within the object.
    var requiredServices: [UtilityType.Service] { get }

    /// These are the services that can be used within the object. These are updated when a service is toggled on/off
    var accessibleServices: [UtilityType.Service: any Service] { get async }

    /// This function returns the service from the `accessibleServices` variable.
    func getService<T: Service>(ofType serviceType: UtilityType.Service) async -> T?
}

// Overridable Default Implementations
extension ServicesRequiring {
    nonisolated var accessibleServices: [UtilityType.Service : any Service] {
        get async {
            var dictionary: [UtilityType.Service : Service] = [:]
            await requiredServices.asyncForEach { serviceType in
                if let service = await ServiceResolver.shared.resolveService(ofType: serviceType) {
                    dictionary.updateValue(service, forKey: serviceType)
                }
            }
            return dictionary
        }
    }

    func getService<T: Service>(ofType serviceType: UtilityType.Service) async -> T? {
        return await accessibleServices[serviceType] as? T
    }
}
