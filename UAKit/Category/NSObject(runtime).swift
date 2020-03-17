//
//  NSObject(runtime).swift
//  SimilarPro
//
//  Created by ZD on 2020/2/26.
//  Copyright © 2020 ZD. All rights reserved.
//

import UIKit

extension NSObject {
    
    func getPorpertyNames<T>(clazz: T) -> [String] {
        var count: UInt32 = 0
        let ivars = class_copyIvarList(clazz as? AnyClass, &count)!
        var res = [String]()
        for i in 0..<count {
            let nameP = ivar_getName(ivars[Int(i)])!
            let name = String.init(cString: nameP)
            res.append(name)
        }
        return res
    }
    
}


