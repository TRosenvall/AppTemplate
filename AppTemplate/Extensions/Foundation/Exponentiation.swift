//
//  Exponentiation.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/30/22.
//

import Foundation

precedencegroup ExponentiationPrecedence {
    associativity: right
    higherThan: MultiplicationPrecedence
}

infix operator ** : ExponentiationPrecedence

func ** (_ base: Double,
         _ exp: Double) -> Double {
    return pow(base, exp)
}

func ** (_ base: Float,
         _ exp: Float) -> Float {
    return pow(base, exp)
}
