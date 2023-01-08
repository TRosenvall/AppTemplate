//
//  UIView.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/30/22.
//

import UIKit

extension UIView {
    func getHypotenuse() -> CGFloat {
        return (frame.width ** 2 + frame.height ** 2) ** (1/2)
    }
}
