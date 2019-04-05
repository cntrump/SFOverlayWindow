//
//  OverlayWindow.swift
//  SFOverlayWindow
//
//  Created by vvveiii on 2019/4/3.
//  Copyright © 2019 vvveiii. All rights reserved.
//

import UIKit

@available(iOSApplicationExtension, unavailable)
@objc public class SFOverlayWindow: UIWindow {
    private var _innerLevel: UIWindow.Level = .normal
    override public var windowLevel: UIWindow.Level {
        get {
            return _innerLevel
        }

        set {
            _innerLevel = newValue
        }
    }

    private var mainWindow: UIWindow? {
        get {
            return UIApplication.shared.delegate?.window as? UIWindow
        }
    }

    private var rootVC: OverlayViewController? {
        get {
            return rootViewController as? OverlayViewController
        }
    }

    @objc public class func window() -> Self {
        return self.init()
    }

    @objc public override init(frame: CGRect) {
        super.init(frame: frame)

        rootViewController = OverlayViewController()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc open func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        guard isHidden, mainWindow != nil, rootVC?.presentedViewController == nil else {
            return
        }

        show()
        rootVC?.present(viewControllerToPresent, animated: flag, completion: completion)
    }

    @objc open func show() {
        show(level: UIWindow.Level(rawValue: 10000002))
    }

    @objc open func show(level: UIWindow.Level) {
        guard isHidden, mainWindow != nil else {
            return
        }

        windowLevel = level
        frame = mainWindow!.frame
        isHidden = false
        backgroundColor = .clear

        rootVC?.view.backgroundColor = .clear
        rootVC?.mainWindow = mainWindow
        rootVC?.rootWindow = self
    }
}

class OverlayViewController: UIViewController {
    fileprivate weak var mainWindow: UIWindow?
    fileprivate var rootWindow: UIWindow?

    override var preferredStatusBarStyle: UIStatusBarStyle {
        guard mainWindow?.rootViewController != nil else {
            return .default
        }

        return mainWindow!.rootViewController!.SFtopPreferredStatusBarStyle
    }

    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag) { [weak self] in
            if let completion = completion {
                completion()
            }

            if self?.presentedViewController == nil {
                self?.rootWindow?.isHidden = true
                self?.rootWindow = nil
            }
        }
    }
}
