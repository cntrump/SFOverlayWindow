//
//  AlertWindow.swift
//  SFOverlayWindow
//
//  Created by vvveiii on 2019/4/3.
//  Copyright © 2019 vvveiii. All rights reserved.
//

import UIKit

@available(iOSApplicationExtension, unavailable)
public class SFAlertWindow: SFOverlayWindow {
    @objc open var title: String? {
        didSet {
            alertRootVC.alertTitle = title
        }
    }

    @objc open var message: String? {
        didSet {
            alertRootVC.alertMessage = message
        }
    }

    private var mainWindow: UIWindow? {
        get {
            return UIApplication.shared.delegate?.window as? UIWindow
        }
    }

    private var alertRootVC: AlertRootController!

    @objc public class func window(title: String?, message: String? = nil) -> Self {
        return self.init(title: title, message: message)
    }

    @objc public class func showAlertMessage(title: String?, message: String? = nil, cancelTitle: String?) {
        let alert = self.init(title: title, message: message)
        alert.addAction(title: cancelTitle, style: .cancel)
        alert.show()
    }

    @objc public required init(title: String?, message: String? = nil) {
        super.init(frame: .zero)

        alertRootVC = AlertRootController(title: title, message: message)
        rootViewController = alertRootVC
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc public func addAction(_ action: UIAlertAction) {
        alertRootVC.addAction(action)
    }

    @objc public func addAction(title: String?, style: UIAlertAction.Style, handler: ((UIAlertAction) -> Void)? = nil) {
        let action = UIAlertAction(title: title, style: style, handler: handler)
        addAction(action)
    }

    @objc public func addCancelAction(title: String?, handler: ((UIAlertAction) -> Void)? = nil) {
        let action = UIAlertAction(title: title, style: .cancel, handler: handler)
        addAction(action)
    }

    @objc public func addDestructiveAction(title: String?, handler: ((UIAlertAction) -> Void)? = nil) {
        let action = UIAlertAction(title: title, style: .destructive, handler: handler)
        addAction(action)
    }

    @objc public func addDefaultAction(title: String?, handler: ((UIAlertAction) -> Void)? = nil) {
        let action = UIAlertAction(title: title, style: .default, handler: handler)
        addAction(action)
    }
    
    @objc override public func show() {
        super.show()
        alertRootVC.show()
    }
}

class AlertRootController: OverlayViewController {
    var alert: UIAlertController!
    var alertTitle: String?
    var alertMessage: String?

    init(title: String?, message: String?) {
        super.init(nibName: nil, bundle: nil)

        alertTitle = title
        alertMessage = message
        alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addAction(_ action: UIAlertAction) {
        alert.addAction(action)
    }

    func show() {
        alert.title = alertTitle
        alert.message = alertMessage
        present(alert, animated: true, completion: nil)
    }
}
