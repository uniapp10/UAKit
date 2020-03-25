//
//  Dimension.swift
//  SimilarPro
//
//  Created by ZD on 2020/2/26.
//  Copyright © 2020 ZD. All rights reserved.
//

import UIKit

let ScreenSize = UIScreen.main.bounds.size
let ScreenWidth = ScreenSize.width
let ScreenHeight = ScreenSize.height

public func Scale(_ width: CGFloat) -> CGFloat {
    return width * ScreenWidth / 375.0
}

public func ScaleH(_ height: CGFloat) -> CGFloat {
    return height * ScreenHeight / 667.0
}
