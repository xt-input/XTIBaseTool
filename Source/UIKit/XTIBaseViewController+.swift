//
//  XTIBaseViewController+.swift
//  XTIBaseUIKit
//
//  Created by xtinput on 2021/5/22.
//

import UIKit
import XTIBaseFoundation
import XTILoger

fileprivate var hookUIViewControllerFlag: Bool = false

extension UIViewController {
    override open class var enabledHook: Bool {
        set {
            hookUIViewControllerFlag = newValue
            if newValue {
                DispatchQueue.xti_once {
                    self.hook()
                }
            }
        }
        get {
            hookUIViewControllerFlag
        }
    }

    fileprivate class func hook() {
        self.xti_exchangeImplementations(#selector(viewDidLoad), swizzledSelector: #selector(xti_viewDidLoad))
        self.xti_exchangeImplementations(#selector(viewWillAppear(_:)), swizzledSelector: #selector(xti_viewWillAppear(_:)))
        self.xti_exchangeImplementations(#selector(viewDidAppear), swizzledSelector: #selector(xti_viewDidAppear(_:)))
        self.xti_exchangeImplementations(#selector(viewWillDisappear), swizzledSelector: #selector(xti_viewWillDisappear(_:)))
        self.xti_exchangeImplementations(#selector(viewDidDisappear), swizzledSelector: #selector(xti_viewDidDisappear(_:)))
        XTIUIKitLoger.debug(self.classForCoder(), " hook完成")
    }
}

@objc public enum XTIUIViewControllerVisibleState: UInt {
    case unknow = 1, didLoad, willAppear, didAppear, willDisappear, didDisappear

    var visible: Bool {
        return self == .willAppear || self == .didAppear
    }
}

@objc extension UIViewController {
    @objc public var xti_visibleState: XTIUIViewControllerVisibleState {
        set {
            objc_setAssociatedObject(self, "xti_visibleState", newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
        get {
            (objc_getAssociatedObject(self, "xti_visibleState") as? XTIUIViewControllerVisibleState) ?? .unknow
        }
    }
}

@objc extension UIViewController {
    func xti_viewDidLoad() {
        self.xti_viewDidLoad()
        self.xti_visibleState = .didLoad
    }

    func xti_viewWillAppear(_ animated: Bool) {
        self.xti_viewWillAppear(animated)
        self.xti_visibleState = .willAppear
    }

    func xti_viewDidAppear(_ animated: Bool) {
        self.xti_viewDidAppear(animated)
        self.xti_visibleState = .didAppear
    }

    func xti_viewWillDisappear(_ animated: Bool) {
        self.xti_viewWillDisappear(animated)
        self.xti_visibleState = .willDisappear
    }

    func xti_viewDidDisappear(_ animated: Bool) {
        self.xti_viewDidDisappear(animated)
        self.xti_visibleState = .didDisappear
    }
}
