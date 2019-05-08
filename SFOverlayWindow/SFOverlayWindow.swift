//
//  OverlayWindow.swift
//  SFOverlayWindow
//
//  Created by vvveiii on 2019/4/3.
//  Copyright © 2019 vvveiii. All rights reserved.
//

import UIKit
import SafariServices

@available(iOSApplicationExtension, unavailable)
@objc public class SFOverlayWindow: UIWindow {
    private var innerWindowLevel: UIWindow.Level = UIWindow.Level(rawValue: 10000002)
    override public var windowLevel: UIWindow.Level {
        get {
            return innerWindowLevel
        }

        set {
            innerWindowLevel = newValue
        }
    }

    internal var mainWindow: UIWindow? {
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

    @objc(presentViewController:animated:completion:)
    open func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        guard isHidden, mainWindow != nil, rootVC?.presentedViewController == nil else {
            return
        }

        if #available(iOS 9.0, *) {
            if isKind(of: SFSafariWindow.self) {
                if !viewControllerToPresent.isKind(of: SFSafariViewController.self) {
                    return
                }

                let vc = viewControllerToPresent as! SFSafariViewController
                if vc.delegate == nil || !vc.delegate!.isEqual(self) {
                    return
                }
            }
        }

        show()

        DispatchQueue.main.async { [weak self] in
            self?.rootVC?.present(viewControllerToPresent, animated: flag, completion: completion)
        }
    }

    @objc open func show() {
        show(level: windowLevel)
    }

    @objc open func show(level: UIWindow.Level) {
        guard isHidden, mainWindow != nil else {
            return
        }

        rootVC?.view.backgroundColor = .clear
        rootVC?.mainWindow = mainWindow
        rootVC?.rootWindow = self

        windowLevel = level
        frame = mainWindow!.frame
        backgroundColor = .clear
        makeKeyAndVisible()
    }

    internal func destory() {
        isHidden = true
        rootViewController = nil
        mainWindow?.makeKey()
    }
}

class OverlayViewController: UIViewController {
    fileprivate weak var mainWindow: UIWindow?
    fileprivate var rootWindow: SFOverlayWindow?

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
                self?.rootWindow?.destory()
            }
        }
    }
}
