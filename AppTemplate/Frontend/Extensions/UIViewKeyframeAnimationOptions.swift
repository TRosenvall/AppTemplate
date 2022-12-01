//
//  UIViewKeyframeAnimationOptions.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/30/22.
//

import UIKit

extension UIView.KeyframeAnimationOptions {
    static var curveLinear: UIView.KeyframeAnimationOptions =
        UIView.KeyframeAnimationOptions(rawValue: UIView.AnimationOptions.curveLinear.rawValue)

    static var curveEaseInOut: UIView.KeyframeAnimationOptions =
        UIView.KeyframeAnimationOptions(rawValue: UIView.AnimationOptions.curveEaseInOut.rawValue)

    static var curveEaseIn: UIView.KeyframeAnimationOptions =
        UIView.KeyframeAnimationOptions(rawValue: UIView.AnimationOptions.curveEaseIn.rawValue)

    static var curveEaseOut: UIView.KeyframeAnimationOptions =
        UIView.KeyframeAnimationOptions(rawValue: UIView.AnimationOptions.curveEaseOut.rawValue)

    init(animationOptions: UIView.AnimationOptions) {
        self.init(rawValue: animationOptions.rawValue)
    }
}
