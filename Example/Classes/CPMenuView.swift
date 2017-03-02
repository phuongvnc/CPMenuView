//
//  CPMenuView.swift
//  CPMenuView
//
//  Created by framgia on 2/22/17.
//  Copyright © 2017 framgia. All rights reserved.
//

import UIKit

enum CPMenuType {
    case all
    case half
    case quarter
}

public enum CPMenuViewState {
    case none
    case expand
}

protocol CPMenuViewDelegate: class {
    func menuView(_ menuView: CPMenuView, didSelectButtonAtIndex index: Int)
    func menuView(_ menuView: CPMenuView, didSelectHomeButtonState state: CPMenuViewState)
}

protocol CPMenuViewDataSource: class {
    func menuViewNumberOfItems() -> Int
    func menuView(_ : CPMenuView, buttonAtIndex index: Int) -> SubMenuButton
}

class CPMenuView {

    fileprivate var parentView: UIView?
    fileprivate var homeButton: HomeMenuButton?
    fileprivate var animator: CPMenuAnimator?
    fileprivate var menuButtons:[SubMenuButton] = []

    var type: CPMenuType = .all
    var isClockWise = true // Default is clockwise
    var radius: Double = 100 // Default radius

    fileprivate(set) var state: CPMenuViewState = .none {
        didSet {
            state == .none ? animator?.animationHideSubMenuButton(subButtons: menuButtons, completion: nil) : animator?.animationShowSubMenuButton(subButtons: menuButtons, completion: nil)
            animator?.animationHomeButton(homeButton: homeButton!, state: state, completion: nil)
            setHomeButtonImage(pressed: state == .expand)
        }
    }

    var datasource: CPMenuViewDataSource?
    var delegate: CPMenuViewDelegate?



    public init(parentView: UIView, homeButton: HomeMenuButton, animator: CPMenuAnimator ,type: CPMenuType,radius: Double = 100, isClockWise: Bool) {
        self.parentView = parentView
        self.homeButton = homeButton
        self.animator = animator
        self.type = type
        self.radius = radius
        self.isClockWise = isClockWise
        setup()
    }

    convenience public init(parentView: UIView, homeButton: HomeMenuButton, type: CPMenuType = .all ,radius: Double = 100, isClockWise: Bool = true) {
        self.init(parentView: parentView, homeButton: homeButton, animator: CPMenuAnimator(), type: type, radius: radius, isClockWise: isClockWise)
    }

    private func setup() {
        setUpHomeButton()
    }

    fileprivate func setUpHomeButton() {
        guard let parentView = parentView else {
            return
        }
        setUpDefaultHomeButtonPosition()
        homeButton?.delegate = self
        parentView.addSubview(homeButton!)
        parentView.bringSubview(toFront: homeButton!)
    }

    fileprivate func setUpDefaultHomeButtonPosition() {
        guard let parentView = parentView else {
            return
        }
        homeButton?.center = parentView.center
    }


    func reloadButton() {
        state = .none
        removeButton()
        addButton()
        layoutButton()
    }

    private func addButton() {
        guard let numberOfItem = datasource?.menuViewNumberOfItems() else { return }
        for i in 0..<numberOfItem {
            let button = datasource!.menuView(self, buttonAtIndex: i)
            button.delegate = self
            parentView?.addSubview(button)
            parentView?.bringSubview(toFront: button)
            menuButtons.append(button)

        }
    }

    private func removeButton() {
        let _ =  menuButtons.map { $0.removeFromSuperview() }
        menuButtons.removeAll()
    }

    private func layoutButton() {
        let theta = getTheta()
        let flip: Double = isClockWise ? 1 : -1
        var index = 0
        let center = CGPoint(x: homeButton!.frame.midX, y: homeButton!.frame.midY)
        menuButtons.forEach { (item) in
            let x = Double(center.x) + sin(Double(index) * theta) * radius * flip
            let y = Double(center.y) - cos(Double(index) * theta) * radius
            item.center = center
            item.startPosition = center
            item.endPosition = CGPoint(x: x, y: y)
            item.index = index
            item.alpha = 0
            index += 1
        }

    }

    private func getTheta() -> Double {
        let numberItem: Double = Double(datasource!.menuViewNumberOfItems() == 0 ? 1 : datasource!.menuViewNumberOfItems() - 1)
        switch type {
        case .all:
            return 2 * M_PI / (numberItem + 1)
        case .half:
            return M_PI / numberItem
        case .quarter:
            return M_PI_2 / numberItem
        }
    }

    private func setHomeButtonImage(pressed: Bool) {
        homeButton?.markAsPressed(pressed)
    }


    func setHomeButtonPosition(position: CGPoint) {
        homeButton?.center = position
        reloadButton()
    }


}

extension CPMenuView: CPMenuButtonDelegate {
    func didSelectButton(sender: CPMenuButton) {
        if let subMenuButton = sender as? SubMenuButton, let indexOfItem = menuButtons.index(of: subMenuButton) {
            state = .none
            delegate?.menuView(self, didSelectButtonAtIndex: indexOfItem)
        } else {
            state = state == .none ? .expand : .none
            delegate?.menuView(self, didSelectHomeButtonState: state)
        }
    }
}

