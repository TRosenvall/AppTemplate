//
//  ActivityIndicatorTheme.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 2/25/23.
//

import UIKit

class ActivityIndicatorTheme: ComponentTheme {
    var view: Component?

    var indicatorBackground: UIColor
    var backgroundColor: UIColor

    init(base: AppTheme,
         indicatorBackground: UIColor? = nil,
         backgroundColor: UIColor? = nil) {
        self.indicatorBackground = indicatorBackground ?? base.colors.viewBackgroundColor!
        self.backgroundColor = backgroundColor ?? base.colors.viewBackgroundColor!
    }

    func apply() {
        view?.backgroundColor = .blue
    }
}
