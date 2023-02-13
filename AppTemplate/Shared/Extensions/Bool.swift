//
//  Bool.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 2/3/23.
//

import Foundation

extension Bool: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self = value != 0
    }
}
