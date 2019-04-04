//
//  UIViewController+extension.swift
//  SFOverlayWindow
//
//  Created by vvveiii on 2019/4/3.
//  Copyright © 2019 vvveiii. All rights reserved.
//

import UIKit

public extension UIViewController {
    @objc var SFtopPreferredStatusBarStyle: UIStatusBarStyle {
        get {
            let isNav = self.isKind(of: UINavigationController.self)
            let isTab = self.isKind(of: UITabBarController.self)

            guard isNav || isTab || presentedViewController != nil else {
                return self.preferredStatusBarStyle
            }

            var style: UIStatusBarStyle = .default

            if let presentedViewController = presentedViewController {
                style = presentedViewController.SFtopPreferredStatusBarStyle
            } else if isTab {
                if let selectedViewController = (self as! UITabBarController).selectedViewController {
                    style = selectedViewController.SFtopPreferredStatusBarStyle
                }
            } else if isNav {
                if let topViewController = (self as! UINavigationController).topViewController {
                    style = topViewController.SFtopPreferredStatusBarStyle
                }
            }

            return style
        }
    }
}
