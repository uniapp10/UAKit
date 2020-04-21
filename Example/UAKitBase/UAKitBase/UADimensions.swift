//
//  UADimensions.swift
//  UAKitBase
//
//  Created by ZD on 2020/4/18.
//  Copyright © 2020 ZD. All rights reserved.
//

import UIKit

public let ScreenWidth: CGFloat = UIScreen.main.bounds.size.width
public let ScreenHeight: CGFloat = UIScreen.main.bounds.size.height

/// 以iPhoneX为基础进行匹配宽度
/// - Parameter width: 宽度
public func ScaleW(_ width: CGFloat) -> CGFloat {
    return width * 375 / ScreenWidth
}

/// 以iPhoneX为基础进行匹配高度
/// - Parameter height: 高度
public func ScaleH(_ height: CGFloat) -> CGFloat {
    return height * 812 / ScreenHeight
}

public extension UIScreen {
    static let statusBarHeight = UIApplication.shared.statusBarFrame.height
    static let topBarHeight = UIDevice.isPhoneX ? 88.0 : 64.0
    static let bottomBarHeight = UIDevice.isPhoneX ? 83.0 : 49.0
    static let bottomHeight = UIDevice.isPhoneX ? 34.0 : 0.0
    static let maxLength: CGFloat = max(ScreenWidth, ScreenHeight)
    static let minLength: CGFloat = min(ScreenWidth, ScreenHeight)
}
