//
//  XTICGGeometry+.swift
//
//  Created by xtinput on 2020/12/24.
//

import UIKit

/// 判断设备类型

fileprivate var Bool_isAlienScreen: Bool?
fileprivate var SCREENInfo_SafeAreaInsets: UIEdgeInsets?

public extension XTITypeOriginalProtocol where OriginalType == Bool {
    static var isMainThread: Bool {
        return OperationQueue.current?.underlyingQueue?.label == DispatchQueue.main.label
    }

    static var isIphone5: Bool {
        let size = CGSize.xti.screenSize
        return size.equalTo(CGSize(width: 320, height: 568)) || size.equalTo(CGSize(width: 568, height: 320))
    }

    static var isIphone: Bool {
        let size = CGSize.xti.screenSize
        return size.equalTo(CGSize(width: 375, height: 667)) || size.equalTo(CGSize(width: 667, height: 375))
    }

    static var isIphonePuls: Bool {
        let size = CGSize.xti.screenSize
        return size.equalTo(CGSize(width: 414, height: 736)) || size.equalTo(CGSize(width: 736, height: 414))
    }

    static var isAlienScreen: Bool {
        if #available(iOS 11.0, *) {
            if Bool_isAlienScreen == nil {
                if SCREENInfo_SafeAreaInsets == nil {
                    if Bool.xti.isMainThread {
                        SCREENInfo_SafeAreaInsets = UIWindow(frame: CGRect.xti.screenBounds).safeAreaInsets
                    } else {
                        DispatchQueue.main.sync {
                            SCREENInfo_SafeAreaInsets = UIWindow(frame: CGRect.xti.screenBounds).safeAreaInsets
                        }
                    }
                }
                let safeAreaInsets = SCREENInfo_SafeAreaInsets ?? UIEdgeInsets.zero
                Bool_isAlienScreen = safeAreaInsets != UIEdgeInsets.zero
            }
            return Bool_isAlienScreen ?? false
        } else {
            return false
        }
    }

    static var isLandscape: Bool {
        let orientation = UIApplication.shared.statusBarOrientation
        return orientation == .landscapeLeft || orientation == .landscapeRight
    }
}

/// 获取设备一些尺寸
public extension XTITypeOriginalProtocol where OriginalType == CGRect {
    static var screenBounds: CGRect {
        return UIScreen.main.bounds
    }
}

public extension XTITypeOriginalProtocol where OriginalType == CGSize {
    /// 屏幕大小
    static var screenSize: CGSize {
        return CGRect.xti.screenBounds.size
    }
}

fileprivate var CGFloat_STATUS_HEIGHT: CGFloat?

public extension XTITypeOriginalProtocol where OriginalType == CGFloat {
    /// 屏幕宽度
    static var screenWidth: CGFloat {
        return CGSize.xti.screenSize.width
    }

    /// 屏幕高度
    static var screenHeight: CGFloat {
        return CGSize.xti.screenSize.height
    }

    /// 状态栏安全高度
    static var statusHeight: CGFloat {
        if #available(iOS 11.0, *) {
            if Bool.xti.isAlienScreen {
                if CGFloat_STATUS_HEIGHT == nil {
                    if SCREENInfo_SafeAreaInsets == nil {
                        if Bool.xti.isMainThread {
                            SCREENInfo_SafeAreaInsets = UIWindow(frame: CGRect.xti.screenBounds).safeAreaInsets
                        } else {
                            DispatchQueue.main.sync {
                                SCREENInfo_SafeAreaInsets = UIWindow(frame: CGRect.xti.screenBounds).safeAreaInsets
                            }
                        }
                    }
                    let safeAreaInsets = SCREENInfo_SafeAreaInsets ?? UIEdgeInsets.zero
                    if safeAreaInsets.top == 0 {
                        CGFloat_STATUS_HEIGHT = max(safeAreaInsets.left, safeAreaInsets.left)
                    } else {
                        CGFloat_STATUS_HEIGHT = safeAreaInsets.top
                    }
                }
                return CGFloat_STATUS_HEIGHT ?? 44.0
            }
        }
        return 20.0
    }

    /// 异形屏 机型 底部控制栏高度
    static var buttonHeight: CGFloat {
        return Bool.xti.isAlienScreen ? 34.0 : 0.0
    }

    /// tabbar的安全高度
    static var tabbarHeight: CGFloat {
        return Bool.xti.isAlienScreen ? 83.0 : 49.0
    }

    /// 导航控制器安全高度
    static var navbarHeight: CGFloat {
        return Bool.xti.isAlienScreen ? 88.0 : 64.0
    }
}
