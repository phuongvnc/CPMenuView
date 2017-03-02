//
//  CPMenuButton.swift
//  CPMenuView
//
//  Created by framgia on 2/22/17.
//  Copyright © 2017 framgia. All rights reserved.
//

import UIKit

protocol CPSubMenuButtonProtocol {
    var index: Int { get set }
    var startPosition: CGPoint? { get set }
    var endPosition: CGPoint? { get set }
}

protocol CPMenuButtonDelegate: class {
    func didSelectButton(sender: CPMenuButton)
}

public class CPMenuButton: UIView {

    private lazy var menuImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(origin: CGPoint.zero, size: self.frame.size))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    weak var delegate: CPMenuButtonDelegate?


    var image: UIImage? {
        didSet {
            setUpImageView()
        }
    }

    var size: CGSize? {
        didSet {
            if let size = size {
                frame.size = size
            }
        }
    }

    var offset: CGFloat = 0 {
        didSet {
            let sizeImage = CGSize(width: frame.size.width - offset , height: frame.size.height - offset)
            menuImageView.frame.size = sizeImage
            menuImageView.center = center
        }
    }


    init(image: UIImage, size: CGSize? = nil) {
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

    private func setUpImageView() {
        menuImageView.image = image
    }

    func tap(gesture: UITapGestureRecognizer) {
        delegate?.didSelectButton(sender: gesture.view as! CPMenuButton)
    }
}

public class SubMenuButton: CPMenuButton, CPSubMenuButtonProtocol {
    var index = 0
    var startPosition: CGPoint?
    var endPosition: CGPoint?
}

public class HomeMenuButton: CPMenuButton {
    var pressedImage: UIImage?
    var notPressedImage: UIImage?

    func markAsPressed(_ pressed: Bool) {
        notPressedImage = notPressedImage ?? image
        image = pressed ? pressedImage : notPressedImage
    }
}

