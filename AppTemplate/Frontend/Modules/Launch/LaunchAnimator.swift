//
//  LaunchAnimator.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/29/22.
//

import UIKit

class LaunchAnimator: LaunchAnimating {
//
//    // MARK: - Properties
//    let viewController: LaunchView
//    let output: LaunchOutput
//
//    var didFinishLoading = false
//
//    // MARK: - Initializers
//    init(viewController: LaunchView,
//         output: LaunchOutput) {
//        self.viewController = viewController
//        self.output = output
//    }
//
//    // MARK: - LaunchAnimating Functions
//    func animateViewDidAppear(completion: ((Bool) -> Void)?) {
//        guard let logoImageView = self.viewController.logoImageView else { return }
//        let scalingFactor = logoImageView.frame.width / logoImageView.getHypotenuse()
//
//        // Shrink the logo to it's scaled size so it fits on the screen while rotating.
//        UIView.animateKeyframes(withDuration: 0.35,
//                                delay: 0.35,
//                                options: [.calculationModeLinear], animations: {
//
//            UIView.addKeyframe(withRelativeStartTime: 0,
//                               relativeDuration: 1) {
//                logoImageView.transform = .init(scaleX: scalingFactor, y: scalingFactor)
//            }
//
//        }) { _ in
//            self.animateLoading(completion: completion)
//        }
//    }
//
//    func animateLoading(completion: ((Bool) -> Void)?) {
//        guard let logoImageView = self.viewController.logoImageView else { return }
//        let scalingFactor = logoImageView.frame.width / logoImageView.getHypotenuse()
//        let duration = 1.5
//
//        // Rotate the logo by 360 degrees at it's scaled size
//        UIView.animateKeyframes(withDuration: duration,
//                                delay: 0,
//                                options: [.calculationModeLinear],
//                                animations: {
//            for i in 0 ..< 4 {
//                UIView.addKeyframe(withRelativeStartTime: 0.25 * Double(i),
//                                   relativeDuration: 0.25) {
//                    let angle = CGFloat.pi / 2 * CGFloat(i + 1)
//                    logoImageView.transform = .init(rotationAngle: angle)
//                                              .scaledBy(x: scalingFactor, y: scalingFactor)
//                }
//            }
//        }) { _ in
//            if self.didFinishLoading {
//                self.animateDidFinishLoading(completion: completion)
//            } else {
//                self.animateLoading(completion: completion)
//            }
//        }
//    }
//
//    func animateDidFinishLoading(completion: ((Bool) -> Void)?) {
//        let logoImageView = self.viewController.logoImageView
//
//        // Shrink the logo to it's scaled size so it fits on the screen while rotating.
//        UIView.animateKeyframes(withDuration: 0.2,
//                                delay: 0.35,
//                                options: [.calculationModeLinear], animations: {
//
//            UIView.addKeyframe(withRelativeStartTime: 0,
//                               relativeDuration: 1) {
//                logoImageView?.transform = .init(scaleX: 1, y: 1)
//                logoImageView?.alpha = 0.44
//            }
//
//        }, completion: completion)
//    }
//
//    // MARK: - Helper Functions

}
