//
//  Errors.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 2/19/23.
//

import Foundation

enum AppErrors {
    enum Service: Error, CanLogErrors {
        case ServiceNotFound
        
        enum Persistence: Error, CanLogErrors {
            case UnableToRetrieveData
            case UnableToWriteData
        }
    }

    enum Module: Error, CanLogErrors {
        
    }

    enum Shared: Error, CanLogErrors {
        case EntityNotConfigured
    }
}
