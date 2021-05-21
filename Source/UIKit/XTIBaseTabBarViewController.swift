//
//  XTIBaseTabBarViewController.swift
//  XTIBaseUIKit
//
//  Created by xtinput on 2021/5/11.
//

import UIKit

open class XTIBaseTabBarViewController: UITabBarController {
    open func addChild(xti child: UIViewController, title: String = "", image: UIImage, selectedImage: UIImage? = nil) {
        let tabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage ?? image)
        child.tabBarItem = tabBarItem
        self.addChild(child)
    }

    override open var childForHomeIndicatorAutoHidden: UIViewController? {
        return self.selectedViewController
    }

    // MARK: - 屏幕旋转

    override open var shouldAutorotate: Bool {
        guard var visibleViewController = self.presentedViewController else {
            return self.selectedViewController?.shouldAutorotate ?? true
        }
        return visibleViewController.shouldAutorotate
    }

    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        guard var visibleViewController = self.presentedViewController else {
            return self.selectedViewController?.supportedInterfaceOrientations ?? .all
        }

        if "\(visibleViewController.classForCoder)" == "AV" + "FullScreen" + "ViewController" {
            return visibleViewController.supportedInterfaceOrientations
        }

        if visibleViewController.isBeingDismissed || ((visibleViewController as? UIAlertController) != nil) {
            return self.selectedViewController?.supportedInterfaceOrientations ?? .all
        }

        return visibleViewController.supportedInterfaceOrientations
    }
}
