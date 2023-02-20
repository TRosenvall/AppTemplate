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

        enum Coding: Error, CanLogErrors {
            case NoDataFound
        }

        enum Encryption: Error, CanLogErrors {
            case UnableToRetrieveSymmetricKey
            case UnableToVerifyDataAndKey
        }

        enum DataRouting: Error, CanLogErrors {
            case EncryptionNotNeeded
            case UnableToDecodeEntity
        }
    }

    enum Module: Error, CanLogErrors {
        
    }

    enum Shared: Error, CanLogErrors {
        case EntityNotConfigured
    }
}
