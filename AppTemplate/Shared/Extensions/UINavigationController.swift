//
//  UINavigationController.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 11/30/22.
//

import UIKit

extension UINavigationController {
    func setModal(presentationStyle: UIModalPresentationStyle) async {
        self.modalPresentationStyle = presentationStyle
    }

    func setModal(transitionStyle: UIModalTransitionStyle) async {
        self.modalTransitionStyle = transitionStyle
    }

    func pushFromLeft(controller: UIViewController) {
        guard let window = view.window else {
            return
        }

        let transition = CATransition()
        transition.duration = 0.35
        transition.type = .push
        transition.subtype = .fromLeft
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        window.layer.add(transition, forKey: kCATransition)
        pushViewController(controller, animated: false)
    }

    func popToLeft() {
        guard let window = view.window else {
            return
        }

        let transition = CATransition()
        transition.duration = 0.35
        transition.type = .push
        transition.subtype = .fromRight
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        window.layer.add(transition, forKey: kCATransition)
        popViewController(animated: false)
    }
}
