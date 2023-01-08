//
//  CodingContracts.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 12/15/22.
//

import Foundation

/// This service handles all of the encoding and decoding throughout the app.
/// If this service is toggled off, then any instance of this service should be set to nil everywhere and no saving
/// should be able to occur anywhere, though saving/loading of the core services remain activeto facilitate regular app
/// usage. By default, this service cannot be toggled off.

///------

protocol CodingServing: Service {
    func encode<T: Encodable>(_ object: T) throws -> Data?
    func decode<T: Decodable>(data: Data?) throws -> T
}

extension CodingServing {
    var encoder: JSONEncoder {
        return JSONEncoder()
    }
    var decoder: JSONDecoder {
        return JSONDecoder()
    }
}

///------
