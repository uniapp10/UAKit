//
//  UADevice.swift
//  UAKitBase
//
//  Created by ZD on 2020/4/18.
//  Copyright © 2020 ZD. All rights reserved.
//

import UIKit

public extension UIDevice {
    static let isIpad:Bool = UI_USER_INTERFACE_IDIOM() == .pad ? true:false
    static let isIphone:Bool = UI_USER_INTERFACE_IDIOM() == .phone ? true:false
    static let isPhone5 = isIphone && (UIScreen.maxLength == 568.0)
    static let isPhone6 = isIphone && (UIScreen.maxLength == 667.0)
    static let isPhone6P = isIphone && (UIScreen.maxLength == 736.0)
    static let isPhoneX = isIphone && (UIScreen.maxLength >= 812)    
}
