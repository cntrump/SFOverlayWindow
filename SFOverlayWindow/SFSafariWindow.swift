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
    @objc(presentURL:animated:completion:)
    open func present(_ url: URL, animated flag: Bool, completion: (() -> Void)? = nil) {
        let vc = SFSafariViewController(url: url)
        vc.delegate = self
        present(vc, animated: flag, completion: completion)
    }

    public func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { [weak self] in
            self?.destory()
        })
    }
}
