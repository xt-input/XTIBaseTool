//
//  XTIBaseNamespace.swift
//  XTInputKit
//
//  Created by xt-input on 2017/3/30.
//  Copyright © 2017年 tcoding.cn. All rights reserved.
//
import UIKit

public protocol XTIBaseNamespace {
    associatedtype OriginalType
    var xti: OriginalType { get }
    static var xti: OriginalType.Type { get }
}

public protocol XTITypeOriginalProtocol {
    associatedtype OriginalType
    var originalValue: OriginalType { get }
    init(value: OriginalType)
}

public struct XTINamespaceOriginal<T>: XTITypeOriginalProtocol {
    public var originalValue: T
    public init(value: T) {
        originalValue = value
    }
}

public extension XTIBaseNamespace {
    var xti: XTINamespaceOriginal<Self> {
        return XTINamespaceOriginal(value: self)
    }

    static var xti: XTINamespaceOriginal<Self>.Type {
        return XTINamespaceOriginal.self
    }
}

/// 请在这里添加所有的实现XTIBaseNamespace的类和结构体，避免出现重复
extension CGRect: XTIBaseNamespace {}
extension CGSize: XTIBaseNamespace {}
extension CGFloat: XTIBaseNamespace {}
extension Bool: XTIBaseNamespace {}
