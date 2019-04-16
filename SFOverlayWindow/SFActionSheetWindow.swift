//
//  ActionSheetWindow.swift
//  SFOverlayWindow
//
//  Created by vvveiii on 2019/4/3.
//  Copyright © 2019 vvveiii. All rights reserved.
//

import UIKit

@available(iOSApplicationExtension, unavailable)
public class SFActionSheetWindow: SFOverlayWindow {
    @objc open var title: String? {
        didSet {
            actionSheetRootVC.alertTitle = title
        }
    }

    @objc open var message: String? {
        didSet {
            actionSheetRootVC.alertMessage = message
        }
    }

    private var mainWindow: UIWindow? {
        get {
            return UIApplication.shared.delegate?.window as? UIWindow
        }
    }

    private var actionSheetRootVC: ActionSheetRootController!

    @objc public class func window(title: String?, message: String? = nil) -> Self {
        return self.init(title: title, message: message)
    }

    @objc public required init(title: String?, message: String? = nil) {
        super.init(frame: .zero)

        actionSheetRootVC = ActionSheetRootController(title: title, message: message)
        rootViewController = actionSheetRootVC
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc public func addAction(_ action: UIAlertAction) {
        actionSheetRootVC.addAction(action)
    }

    @objc public func addAction(title: String?, style: UIAlertAction.Style, handler: ((UIAlertAction) -> Void)? = nil) {
        guard let title = title else {
            return
        }

        let action = UIAlertAction(title: title, style: style, handler: handler)
        addAction(action)
    }

    @objc public func addCancelAction(title: String?, handler: ((UIAlertAction) -> Void)? = nil) {
        addAction(title: title, style: .cancel, handler: handler)
    }

    @objc public func addDestructiveAction(title: String?, handler: ((UIAlertAction) -> Void)? = nil) {
        addAction(title: title, style: .destructive, handler: handler)
    }

    @objc public func addDefaultAction(title: String?, handler: ((UIAlertAction) -> Void)? = nil) {
        addAction(title: title, style: .default, handler: handler)
    }

    @objc override public func show() {
        super.show()
        actionSheetRootVC.show()
    }
}

class ActionSheetRootController: OverlayViewController {
    var alert: UIAlertController!
    var alertTitle: String?
    var alertMessage: String?
    var sourceView: UIView?
    lazy var isPad: Bool = UIDevice.current.userInterfaceIdiom == .pad

    init(title: String?, message: String?) {
        super.init(nibName: nil, bundle: nil)

        alertTitle = title
        alertMessage = message
        alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        if isPad {
            sourceView = UIView(frame: .zero)
            if let sourceView = sourceView {
                self.view.addSubview(sourceView)
                sourceView.translatesAutoresizingMaskIntoConstraints = false
                self.view.addConstraints([
                    NSLayoutConstraint(item: sourceView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0),
                    NSLayoutConstraint(item: sourceView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0),
                    NSLayoutConstraint(item: sourceView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0),
                    NSLayoutConstraint(item: sourceView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0)
                    ])
            }
        }
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

        if isPad, let sourceView = sourceView, let popoverPresentationController = alert.popoverPresentationController {
            popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
            popoverPresentationController.sourceView = sourceView
            popoverPresentationController.sourceRect = sourceView.bounds
        }

        present(alert, animated: true, completion: nil)
    }
}
