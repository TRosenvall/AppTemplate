//
//  SymetricKey.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 12/11/22.
//

import Foundation
import CryptoKit

extension SymmetricKey {
    var data: Data {
        return self.withUnsafeBytes { body in
            Data(body)
        }
    }
}
