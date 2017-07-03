//
//  CPMenuButton.swift
//  CPMenuView
//
//  Created by framgia on 2/22/17.
//  Copyright © 2017 framgia. All rights reserved.
//

import UIKit

public protocol CPSubMenuButtonProtocol {
    var index: Int { get set }
    var startPosition: CGPoint? { get set }
    var endPosition: CGPoint? { get set }
}

public protocol CPMenuButtonDelegate: class {
    func didSelectButton(sender: CPMenuButton)
}

public class CPMenuButton: UIView {

    private lazy var menuImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(origin: CGPoint.zero, size: self.frame.size))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    public weak var delegate: CPMenuButtonDelegate?


    public var image: UIImage? {
        didSet {
            setUpImageView()
        }
    }

    public var size: CGSize? {
        didSet {
            if let size = size {
                frame.size = size
            }
        }
    }

    public var offset: CGFloat = 0 {
        didSet {
            let sizeImage = CGSize(width: frame.size.width - offset , height: frame.size.height - offset)
            menuImageView.frame.size = sizeImage
            menuImageView.center = center
        }
    }


    public init(image: UIImage, size: CGSize? = nil) {
        super.init(frame: CGRect.zero)
        self.image = image
        self.size = size
        if let size = size {
            frame.size = size
        } else {
            frame.size = CGSize(width: 50, height: 50)
        }
        menuImageView.image = image
               let tapGesture = UITapGestureRecognizer(target: self, action: #selector(CPMenuButton.tap(gesture:)))
        addGestureRecognizer(tapGesture)
        addSubview(menuImageView)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUpImageView() {
        menuImageView.image = image
    }

    func tap(gesture: UITapGestureRecognizer) {
        delegate?.didSelectButton(sender: gesture.view as! CPMenuButton)
    }
}

public class SubMenuButton: CPMenuButton, CPSubMenuButtonProtocol {
    public var index = 0
    public var startPosition: CGPoint?
    public var endPosition: CGPoint?
}

public class HomeMenuButton: CPMenuButton {
    public var pressedImage: UIImage?
    public var notPressedImage: UIImage?

    public func markAsPressed(_ pressed: Bool) {
        notPressedImage = notPressedImage ?? image
        image = pressed ? pressedImage : notPressedImage
    }
}

