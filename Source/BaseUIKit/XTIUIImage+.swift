//
//  XTIUIImage+.swift
//  XTIBaseUIKit
//
//  Created by xtinput on 2021/5/11.
//

import UIKit

public extension UIImage {
    /// 创建一张纯色的图片
    /// - Parameters:
    ///   - color: 图片颜色
    ///   - size: 图片大小
    convenience init(xti color: UIColor, size: CGSize = CGSize(width: 10, height: 10)) {
        var rect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if let cgImage = image?.cgImage {
            self.init(cgImage: cgImage)
        } else {
            self.init()
        }
    }
}
