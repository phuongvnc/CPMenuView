//
//  ViewController.swift
//  CPMenuViewExpamle
//
//  Created by framgia on 2/27/17.
//  Copyright © 2017 Vo Nguyen Chi Phuong. All rights reserved.
//


import UIKit

class ViewController: UIViewController {

    var menuView: CPMenuView!
    var isShow = false
    override func viewDidLoad() {
        super.viewDidLoad()
        let menuButton = HomeMenuButton(image: UIImage(named:"menu")!, size: CGSize(width: 50, height: 50))
        menuButton.pressedImage = UIImage(named: "close")
        let animator = CPMenuAnimator(commonDuration: 0.5, commonSpringWithDamping: 0.5, commonSpringVelocity: 10)
        menuView = CPMenuView(parentView: self.view, homeButton: menuButton, animator: animator,type: .all,radius: 130, isClockWise: true)
        menuView.delegate = self
        menuView.datasource = self
        menuView.setHomeButtonPosition(position: CGPoint(x: view.center.x, y: view.center.y - 100))

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func changeSegmentedValue(sender: UISegmentedControl) {
        var type = CPMenuType.all
        switch sender.selectedSegmentIndex {
        case 0:
            type = .all
            break
        case 1:
            type = .half
            break
        default:
            type = .quarter
            break
        }

        menuView.type = type
        menuView.reloadButton()
    }

    @IBAction func changeSwitchValue(sender: UISwitch) {
        let isClockWise = sender.isOn
        menuView.isClockWise = isClockWise
        menuView.reloadButton()
    }



}

extension ViewController: CPMenuViewDataSource {
    func menuViewNumberOfItems() -> Int {
        return 5
    }

    func menuView(_: CPMenuView, buttonAtIndex index: Int) -> SubMenuButton {
        let subMenuButton = SubMenuButton(image: UIImage(named:"\(index)")!, size: CGSize(width: 60, height: 60))
        subMenuButton.offset = 20
        subMenuButton.backgroundColor = UIColor.init(red: 243/255.0, green: 156/255.0, blue: 18/255.0, alpha: 1)
        subMenuButton.layer.cornerRadius = subMenuButton.frame.height / 2
        subMenuButton.layer.masksToBounds = true
        return subMenuButton
    }
}

extension ViewController: CPMenuViewDelegate {
    func menuView(_ menuView: CPMenuView, didSelectButtonAtIndex index: Int) {

    }

    func menuView(_ menuView: CPMenuView, didSelectHomeButtonState state: CPMenuViewState) {
        
    }
}
