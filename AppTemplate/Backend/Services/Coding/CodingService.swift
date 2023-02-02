//
//  CodingService.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 12/15/22.
//

import Foundation

class CodingService: CodingServing {

    // MARK: - Properties
    var entityController: (any ModelControlling)?

    // MARK: - Initializers
    init() async throws {
        self.entityController = try await EntityController<CodingVariables>()
    }

    // MARK: - CodingServing Functions
    func encode<T: Encodable>(_ object: T) throws -> Data? {
        return try encoder.encode(object)
    }

    func decode<T: Decodable>(data: Data?) throws -> T {
        guard let data = data else {
            throw "No Data Found"
        }
        return try decoder.decode(T.self, from: data)
    }

    // MARK: - Helper Functions
}
