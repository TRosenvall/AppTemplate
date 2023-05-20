//
//  UIViewController.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 3/5/23.
//

import UIKit

extension UIViewController {
    func setModal(presentationStyle: UIModalPresentationStyle) async {
        self.modalPresentationStyle = presentationStyle
    }

    func setModal(transitionStyle: UIModalTransitionStyle) async {
        self.modalTransitionStyle = transitionStyle
    }
}
