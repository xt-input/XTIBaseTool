//
//  XTIString+.swift
//  XTIBaseFoundation
//
//  Created by xtinput on 2021/5/17.
//

import UIKit

public extension String {
    public func xti_urlQueryEncoded() -> String {
        let characters = CharacterSet.urlQueryAllowed.intersection(CharacterSet(charactersIn: "!$&'()*+,;=:#[]@"))
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters: characters)
        return encodeUrlString ?? ""
    }
}
