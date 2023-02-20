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
    init() {
        self.entityController = EntityController<VariableSet>()
    }

    // MARK: - CodingServing Functions
    func encode<T: Encodable>(_ object: T) throws -> Data? {
        print("1200. Encoding data into \(object)")
        return try encoder.encode(object)
    }

    func decode<T: Decodable>(data: Data?) throws -> T {
        print("1600. Decoding data")
        guard let data = data else {
            print("1601. No data found, throwing.")
            throw AppErrors.Service.Coding.NoDataFound.logError()
        }
        print("1602. Data retrieved, decoding.")
        return try decoder.decode(T.self, from: data)
    }

    // MARK: - Helper Functions
}
