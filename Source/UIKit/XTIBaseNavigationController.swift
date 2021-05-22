//
//  XTIBaseNavigationController.swift
//  XTIBaseUIKit
//
//  Created by xtinput on 2021/5/22.
//

import UIKit

fileprivate var hookNavigationControllerFlag: Bool = false

open class XTIBaseNavigationController: UINavigationController {
    override public init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        self.didInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.didInit()
    }

    open func didInit() {
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension XTIBaseNavigationController {
}
