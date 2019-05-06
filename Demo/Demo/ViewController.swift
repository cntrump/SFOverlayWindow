//
//  ViewController.swift
//  Demo
//
//  Created by vvveiii on 2019/4/3.
//  Copyright © 2019 vvveiii. All rights reserved.
//

import UIKit
import SafariServices

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let testAlertButton = UIButton(type: .system)
        testAlertButton.setTitle("Alert", for: .normal)
        testAlertButton.addTarget(self, action: #selector(testAlert(_:)), for: .touchUpInside)
        view.addSubview(testAlertButton)
        testAlertButton.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            NSLayoutConstraint(item: testAlertButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: testAlertButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0),
            ])

        let testActionSheetButton = UIButton(type: .system)
        testActionSheetButton.setTitle("ActionSheet", for: .normal)
        testActionSheetButton.addTarget(self, action: #selector(testActionSheet(_:)), for: .touchUpInside)
        view.addSubview(testActionSheetButton)
        testActionSheetButton.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            NSLayoutConstraint(item: testActionSheetButton, attribute: .top, relatedBy: .equal, toItem: testAlertButton, attribute: .bottom, multiplier: 1, constant: 10),
            NSLayoutConstraint(item: testActionSheetButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0),
            ])

        let testCustomButton = UIButton(type: .system)
        testCustomButton.setTitle("Custom", for: .normal)
        testCustomButton.addTarget(self, action: #selector(testCustom(_:)), for: .touchUpInside)
        view.addSubview(testCustomButton)
        testCustomButton.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            NSLayoutConstraint(item: testCustomButton, attribute: .top, relatedBy: .equal, toItem: testActionSheetButton, attribute: .bottom, multiplier: 1, constant: 10),
            NSLayoutConstraint(item: testCustomButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0),
            ])

        let testSafariButton = UIButton(type: .system)
        testSafariButton.setTitle("Safari", for: .normal)
        testSafariButton.addTarget(self, action: #selector(testSafari(_:)), for: .touchUpInside)
        view.addSubview(testSafariButton)
        testSafariButton.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            NSLayoutConstraint(item: testSafariButton, attribute: .top, relatedBy: .equal, toItem: testCustomButton, attribute: .bottom, multiplier: 1, constant: 10),
            NSLayoutConstraint(item: testSafariButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0),
            ])
    }

    @objc func testAlert(_: AnyObject) {
        let alert = SFAlertWindow(title: "title", message: "message")
        alert.addAction(title: "default 1", style: .default)
        alert.addAction(title: "default 2", style: .default)
        alert.addAction(title: "default 3", style: .default)
        alert.addAction(title: "destructive", style: .destructive)
        alert.addAction(title: "cancel", style: .cancel)
        alert.show()
    }

    @objc func testActionSheet(_: AnyObject) {
        let actionSheet = SFActionSheetWindow(title: "title", message: "message")
        actionSheet.addAction(title: "default 1", style: .default)
        actionSheet.addAction(title: "default 2", style: .default)
        actionSheet.addAction(title: "default 3", style: .default)
        actionSheet.addAction(title: "destructive", style: .destructive)
        actionSheet.addAction(title: "cancel", style: .cancel)
        actionSheet.show()
    }

    @objc func testCustom(_: AnyObject) {
        SFOverlayWindow.window().present(CustomViewController(), animated: true)
    }

    @objc func testSafari(_: AnyObject) {
        let url = URL(string: "https://github.com")
        SFSafariWindow.window().present(url!, animated: true)
    }
}

class CustomViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.init(white: 0, alpha: 0.3)

        let dismissButton = UIButton(type: .system)
        dismissButton.setTitle("Dismiss", for: .normal)
        dismissButton.addTarget(self, action: #selector(dismissAction(_:)), for: .touchUpInside)
        view.addSubview(dismissButton)
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            NSLayoutConstraint(item: dismissButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: dismissButton, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0),
            ])
    }

    @objc func dismissAction(_: AnyObject) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
