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
/// `Authentication` - TODO - This service is used to authenticate any user with the app's web authentication flow.
/// `DataExpiration` - TODO - This service is used to expire stored data after an amount of time, such as retiring login tokens.
/// `Analytics` - TODO - This service is used to track user interactions with the app.

///------

protocol ServiceVariable: Variable {
    /// This variable is used to define in which order the service entities need to be loaded.
    /// The higher load priorities will be loaded first
    static var loadPriority: Int { get }
}

/// Default Implementations.
extension ServiceVariable {
    /// All services are naturally set to the lowest load priority. This can be overwritten in the <Service>Variables files as needed.
    static var loadPriority: Int {
        return 9999
    }
}

///------

/// Defines what a service is. All services are required to conform to this protocol.
protocol Service {
    /// Associated type used to pull in the type of variables used in the entityController.
    associatedtype VariableSet: ServiceVariable
    
    /// Used to get the current state of the service
    var state: Bool { get async throws }

    /// Any data needing to be stored which is specific to a service is held by the entity instance herein.
    var entityController: (any ModelControlling)? { get set }

    /// Used to update stored values of the service.
    func updateModel(variable: VariableSet, withValue value: Encodable?) async throws

    /// Used to update the state of service from on to off and vice versa
    func toggleState() async throws
}

// Default Implementation
extension Service {
    var utility: VariableSet.ModelUtility {
        VariableSet.utility
    }

    func updateModel(variable: VariableSet, withValue value: Encodable?) async throws {
        let controller = entityController as? EntityController<VariableSet>
        try await controller?.updateModel(variable: variable, withValue: value)
    }
}

///------ Update Service Model Delegate

/// This delegate is used by the settings module to modify the state of the service.
protocol UpdateServiceModelDelegate: Actor {

    /// Gives permission for the conforming object to update the value of a service state.
    func toggleService(ofType serviceType: UtilityType.Service) async throws
}

///------ Service Resolver

protocol ServiceResolving: Actor, UpdateServiceModelDelegate {

    /// A singleton instance to provide global access to the `ServiceResolving` instance.
    static var shared: ServiceResolving { get }

    /// A list of all services in the active state.
    var activeServices: [UtilityType.Service: any Service] { get set }

    /// Needs to be run in order to initialize the services within the service resolver.
    /// This function initializes all services
    /// Then it configures all of the services entityControllers
    /// Then based on the entity, it puts the service in the activeServices dictionary or discards the result.
    func configureServices() async -> [Error]

    /// Used to initialize and configure individual services.
    /// This function initializes a single service
    /// Then it configures the entity immediate and returns the service
    func configureService(ofType serviceType: UtilityType.Service) async throws -> any Service

    /// Used to resolve a copy of an individual service from the activeServices list.
    func resolveService(ofType serviceType: UtilityType.Service) -> (any Service)?
}

///------

protocol ServicesRequiring {

    /// This function returns the service from the `accessibleServices` variable.
    func getService<T: Service>(ofType serviceType: UtilityType.Service) async -> T?
}

/// Overridable Default Implementations
extension ServicesRequiring {
    func getService<T: Service>(ofType serviceType: UtilityType.Service) async -> T? {
        return await ServiceResolver.shared.resolveService(ofType: serviceType) as? T
    }
}
