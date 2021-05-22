//
//  XTIBaseViewController+.swift
//  XTIBaseUIKit
//
//  Created by xtinput on 2021/5/22.
//

import UIKit
fileprivate var hookUIViewControllerFlag: Bool = false

extension UIViewController {
    override open class var enabledHook: Bool {
        set {
            hookUIViewControllerFlag = newValue
        }
        get {
            hookUIViewControllerFlag
        }
    }
}
