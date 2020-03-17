//
//  UIFont(extension).swift
//  SimilarPro
//
//  Created by ZD on 2020/2/26.
//  Copyright © 2020 ZD. All rights reserved.
//

import Foundation
import UIKit

enum FontStyle: String {
    case PingFang_Regular = "PingFangSC-Regular"
    case PingFang_Medium = "PingFangSC-Medium"
    case PingFang_Semibold = "PingFangSC-Semibold"
    case PingFang_Light = "PingFangSC-Light"
}

extension UIFont {
    class func font(_ style:FontStyle, size: CGFloat) -> UIFont {
        return UIFont(name: style.rawValue, size: Scale(size))!
    }
}
