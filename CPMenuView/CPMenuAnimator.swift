//
//  CPMenuAnimator.swift
//  CPMenuView
//
//  Created by framgia on 2/24/17.
//  Copyright © 2017 framgia. All rights reserved.
//

import UIKit

public protocol CPMenuAnimationProtocol {
    func animationHomeButton(homeButton: HomeMenuButton, state: CPMenuViewState, completion: (() -> Void)?)
    func animationShowSubMenuButton(subButtons: [SubMenuButton], completion: (() -> Void)?)
    func animationHideSubMenuButton(subButtons: [SubMenuButton], completion: (() -> Void)?)
}

public struct CPMenuAnimator {
    public var commonDuration: TimeInterval!
    public var commonSpringWithDamping: CGFloat!
    public var commonSpringVelocity:CGFloat!
    
    public init(commonDuration:TimeInterval = 0.5,commonSpringWithDamping:CGFloat = 0.5 ,commonSpringVelocity:CGFloat = 0){
        self.commonDuration = commonDuration
        self.commonSpringWithDamping = commonSpringWithDamping
        self.commonSpringVelocity = commonSpringVelocity
    }
    public func animation(delay: TimeInterval,animation: @escaping () -> Void, completion: @escaping (Bool) -> Void) {
        UIView.animate(withDuration: commonDuration!, delay: delay, usingSpringWithDamping: commonSpringWithDamping, initialSpringVelocity: commonSpringVelocity, options: UIViewAnimationOptions.curveEaseInOut, animations: animation, completion: completion)
    }
}

extension CPMenuAnimator: CPMenuAnimationProtocol {
   public func animationShowSubMenuButton(subButtons: [SubMenuButton], completion: (() -> Void)?) {
        var delay: TimeInterval = 0
        for button in subButtons {
            let completionBlock = button.isEqual(subButtons.last) ? completion : nil
            animation(delay:delay, animation: {
                button.center = button.endPosition!
                button.alpha = 1
            }, completion: { (finish) in
                completionBlock?()
            })
            delay += 0.2
        }
    }

   public func animationHideSubMenuButton(subButtons: [SubMenuButton], completion: (() -> Void)?) {
        var delay: TimeInterval = 0
        for button in subButtons.reversed() {
            let completionBlock = button.isEqual(subButtons.last) ? completion : nil
            animation(delay:delay, animation: {
                button.center = button.startPosition!
                button.alpha = 0
            }, completion: { (finish) in
                completionBlock?()
            })
            delay += 0.2
        }
    }

   public func animationHomeButton(homeButton: HomeMenuButton, state: CPMenuViewState, completion: (() -> Void)?) {
        let scale: CGFloat = state == .expand ? 1.0 : 0.9
        let transform = CGAffineTransform(scaleX: scale, y: scale)
        animation(delay: 0, animation: {
            homeButton.transform = transform
        }, completion: { finish in
            completion?()
        })

    }
}
