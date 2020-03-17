//
//  UIColor(+).swift
//  SimilarPro
//
//  Created by ZD on 2020/2/26.
//  Copyright © 2020 ZD. All rights reserved.
//

import UIKit

extension UIColor {
    /// 类方法---通过RGBA设置颜色
    ///
    /// - Parameters:
    ///   - r: R
    ///   - g: G
    ///   - b: B
    ///   - a: A
    /// - Returns: 颜色对象
    class func rgb(_ r:UInt8 = 255,
                   _ g:UInt8 = 255,
                   _ b:UInt8 = 255,
                   _ a:CGFloat = 1.0) -> (UIColor){
        
        let R = CGFloat(r) / 255.0
        let G = CGFloat(g) / 255.0
        let B = CGFloat(b) / 255.0
        
        return UIColor(red:R, green:G, blue:B, alpha:a)
    }
    
    
    /// 构造方法 设置颜色
    ///
    /// - Parameters:
    ///   - hex: 颜色Int数值
    ///   - alpha: 不透明度
    convenience init(hex:Int, alpha:CGFloat = 1) {
        let r = Int(hex&0xFF0000) >> 16
        let g = Int(hex&0xFF00) >> 8
        let b = Int(hex&0xFF)

        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0

        self.init(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    
    /// 类方法---设置随机颜色
    class var randomColor:UIColor {
        get {
            let r = CGFloat(arc4random() % 256) / 255.0
            let g = CGFloat(arc4random() % 256) / 255.0
            let b = CGFloat(arc4random() % 256) / 255.0
            
            return UIColor(red: r, green: g, blue: b, alpha: 1.0)
        }
    }
}
