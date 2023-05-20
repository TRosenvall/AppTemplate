//
//  ActivityIndicatorView.swift
//  AppTemplate
//
//  Created by Timothy Rosenvall on 3/20/23.
//

import UIKit

class ActivityIndicatorView: UIView, Component {

    @IBOutlet weak var activityIndicatorImageView: UIImageView!

    var theme: ActivityIndicatorTheme? {
        didSet {
            theme?.apply()
        }
    }

    var didFinishLoading: Bool = false

    init(frame: CGRect, theme: ActivityIndicatorTheme) {
        self.theme = theme
        super.init(frame: frame)
        loadNib()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func animateViewDidAppear(completion: ((Bool) -> Void)?) {
        let scalingFactor = activityIndicatorImageView.frame.width / activityIndicatorImageView.getHypotenuse()

        // Shrink the logo to it's scaled size so it fits on the screen while rotating.
        UIView.animateKeyframes(withDuration: 0.35,
                                delay: 0.35,
                                options: [.calculationModeLinear], animations: {

            UIView.addKeyframe(withRelativeStartTime: 0,
                               relativeDuration: 1) {
                self.activityIndicatorImageView.transform = .init(scaleX: scalingFactor, y: scalingFactor)
            }

        }) { _ in
            self.animateLoading(completion: completion)
        }
    }

    func animateLoading(completion: ((Bool) -> Void)?) {
        let scalingFactor = activityIndicatorImageView.frame.width / activityIndicatorImageView.getHypotenuse()
        let duration = 1.5

        // Rotate the logo by 360 degrees at it's scaled size
        UIView.animateKeyframes(withDuration: duration,
                                delay: 0,
                                options: [.calculationModeLinear],
                                animations: {
            for i in 0 ..< 4 {
                UIView.addKeyframe(withRelativeStartTime: 0.25 * Double(i),
                                   relativeDuration: 0.25) {
                    let angle = CGFloat.pi / 2 * CGFloat(i + 1)
                    self.activityIndicatorImageView.transform = .init(rotationAngle: angle)
                                                                .scaledBy(x: scalingFactor, y: scalingFactor)
                }
            }
        }) { _ in
            if self.didFinishLoading {
                self.animateDidFinishLoading(completion: completion)
            } else {
                self.animateLoading(completion: completion)
            }
        }
    }

    func animateDidFinishLoading(completion: ((Bool) -> Void)?) {
        // Shrink the logo to it's scaled size so it fits on the screen while rotating.
        UIView.animateKeyframes(withDuration: 0.2,
                                delay: 0.35,
                                options: [.calculationModeLinear], animations: {

            UIView.addKeyframe(withRelativeStartTime: 0,
                               relativeDuration: 1) {
                self.activityIndicatorImageView?.transform = .init(scaleX: 1, y: 1)
                self.activityIndicatorImageView?.alpha = 0.44
            }

        }, completion: completion)
    }
    
    func setDidFinishLoading(to value: Bool) {
        self.didFinishLoading = value
    }

}
