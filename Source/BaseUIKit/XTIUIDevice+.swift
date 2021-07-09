//
//  XTIUIDevice+.swift
//  XTIBaseTool
//
//  Created by xtinput on 2021/4/23.
//

import UIKit

public extension UIDevice {
    public var xti_deviceModel: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
}
