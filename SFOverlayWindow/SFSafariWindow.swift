//
//  SFSafariWindow.swift
//  SFOverlayWindow
//
//  Created by vvveiii on 2019/5/6.
//  Copyright © 2019 lvv. All rights reserved.
//

import UIKit
import SafariServices

@available(iOS 9.0, *)
@available(iOSApplicationExtension, unavailable)
public class SFSafariWindow: SFOverlayWindow, SFSafariViewControllerDelegate {

    private var _preferredBarTintColor: UIColor? = nil
    @available(iOS 10.0, *)
    @objc open var preferredBarTintColor: UIColor? {
        get {
            return _preferredBarTintColor
        }

        set {
            _preferredBarTintColor = newValue
        }
    }

    private var _preferredControlTintColor: UIColor? = nil
    @available(iOS 10.0, *)
    @objc open var preferredControlTintColor: UIColor? {
        get {
            return _preferredControlTintColor
        }

        set {
            _preferredControlTintColor = newValue
        }
    }

    private var _dismissButtonStyle: Int = 0
    @available(iOS 11.0, *)
    @objc open var dismissButtonStyle: SFSafariViewController.DismissButtonStyle {
        get {
            return SFSafariViewController.DismissButtonStyle(rawValue: _dismissButtonStyle) ?? .done
        }

        set {
            _dismissButtonStyle = newValue.rawValue
        }
    }

    @objc(presentURL:animated:completion:)
    open func present(_ url: URL, animated flag: Bool, completion: (() -> Void)? = nil) {
        windowLevel = .normal
        let vc = SFSafariViewController(url: url)

        if #available(iOS 10.0, *) {
            vc.preferredControlTintColor = preferredControlTintColor
            vc.preferredBarTintColor = preferredBarTintColor
        }

        if #available(iOS 11.0, *) {
            vc.dismissButtonStyle = dismissButtonStyle
        }

        vc.delegate = self
        present(vc, animated: flag, completion: completion)
    }

    public func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: { [weak self] in
            self?.destory()
        })
    }
}
