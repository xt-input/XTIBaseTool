//
//  XTIBaseUIKit.swift
//  XTIBaseUIKit
//  一些组件库内使用的工具方法
//  Created by xtinput on 2021/5/10.
//

import Foundation

/// 启动hook相关方法的接口
protocol XTIBaseUIKitHookProtocol: NSObjectProtocol {
    static var enabledHook: Bool { set get }
}

@objc extension NSObject: XTIBaseUIKitHookProtocol {
    open class var enabledHook: Bool {
        get { return false }
        set {}
    }
}

extension NSObject {
    // 交换两个方法的实现，没做once处理，需要自行判断
    @discardableResult static func xti_hook(_ originSelector: Selector, swizzledSelector: Selector) -> Bool {
        let originClass = self.classForCoder()
        let originMethod = ObjectiveC.class_getInstanceMethod(originClass, originSelector)
        let swizzledMethod = ObjectiveC.class_getInstanceMethod(originClass, swizzledSelector)
        if originMethod != nil && swizzledMethod != nil {
            if ObjectiveC.class_addMethod(originClass, originSelector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!)) {
                ObjectiveC.class_replaceMethod(originClass, swizzledSelector, method_getImplementation(originMethod!), method_getTypeEncoding(originMethod!))
            } else {
                ObjectiveC.method_exchangeImplementations(originMethod!, swizzledMethod!)
            }
            return true
        }
        return false
    }
}
