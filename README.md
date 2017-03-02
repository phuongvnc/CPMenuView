# CPMenuView


Simple circle menu animated :

[![CI Status](https://travis-ci.org/at-phuongvnc/CPMenuView.svg?style=flat)](https://travis-ci.org/at-phuongvnc/CPMenuView)
[![Version](https://img.shields.io/cocoapods/v/CPMenuView.svg?style=flat)](http://cocoapods.org/pods/CPMenuView)
[![License](https://img.shields.io/cocoapods/l/CPMenuView.svg?style=flat)](http://cocoapods.org/pods/CPMenuView)
[![Platform](https://img.shields.io/cocoapods/p/CPMenuView.svg?style=flat)](http://cocoapods.org/pods/CPMenuView)

![alt tag](https://github.com/at-phuongvnc/CPMenuView/blob/master/README/animated.gif)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- Swift 3.0 & Xcode 8
- iOS 8 and later

#### Manual install

Drag and drop folder `CPMenuView` to your project.

## Installation

CPMenuView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "CPMenuView" ~> '1.0.1'
```
## Usage

You can create and custom home button 
```Swift
let menuButton = HomeMenuButton(image: UIImage(named:"menu")!, size: CGSize(width: 50, height: 50))
menuButton.pressedImage = UIImage(named: "close")
```

Set animation of menu 
```Swift
let animator = CPMenuAnimator(commonDuration: 0.5, commonSpringWithDamping: 0.5, commonSpringVelocity: 10)
```
Create menu view 

```Swift
menuView = CPMenuView(parentView: self.view, homeButton: menuButton, animator: animator,type: .all,radius: 130, isClockWise: true)
menuView.delegate = self
menuView.datasource = self
```
You need set position for home button
```Swift
menuView.setHomeButtonPosition(position: CGPoint(x: view.center.x, y: view.center.y - 100))
```

## Contributing

Contributions for bug fixing or improvements are welcome. Feel free to submit a pull request.

## Author

Chi Phuong, vonguyenchiphuong@gmail.com

## License

CPMenuView is available under the MIT license. See the LICENSE file for more info.
