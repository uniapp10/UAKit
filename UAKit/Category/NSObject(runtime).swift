//
//  NSObject(runtime).swift
//  SimilarPro
//
//  Created by ZD on 2020/2/26.
//  Copyright © 2020 ZD. All rights reserved.
//

import UIKit

public extension NSObject {
    
    /// 获取类属性列表（不含父类）
    /// - Parameter clazz: 需要查找的类
    func getPorpertyNames<T>(clazz: T) -> [String] {
        var count: UInt32 = 0
        let ivars = class_copyIvarList(clazz as? AnyClass, &count)!
        var res = [String]()
        for i in 0..<count {
            let nameP = ivar_getName(ivars[Int(i)])!
            let name = String.init(cString: nameP)
            res.append(name)
        }
        free(ivars)
        return res
    }
    
    /// 获取类实例的方法列表(不含父类)，swift4.0 以上需要在类上加关键字 @objcMemember
    /// - Parameter clazz: 传入类型
    func getMethodNames<T>(clazz: T) -> [String] {
        var count: UInt32 = 0
        let methodList = class_copyMethodList(clazz as? AnyClass, &count)!
        var res = [String]()
        for i in 0..<count {
            let method = methodList[Int(i)]
            let name: Selector = method_getName(method)
            let name_s = sel_getName(name)
            let name_s_str = String(cString: name_s, encoding: .utf8) ?? ""
            #if DEBUG
            let imp = method_getImplementation(method)
            let param_count = method_getNumberOfArguments(method)
            let encoding = method_getTypeEncoding(method)
            let encoding_str = String(cString: encoding!, encoding: .utf8) ?? ""
            print("name_m:\(name), imp:\(imp), param_count:\(param_count), encoding:\(encoding_str), name_s:\(name_s_str)")
            #endif
            res.append(name_s_str)
        }
        free(methodList)
        return res
    }
    
    func getClassList(pro: Protocol) {
        let typeCount = Int(objc_getClassList(nil, 0))
        let types = UnsafeMutablePointer<AnyClass>.allocate(capacity: typeCount)
        let autoreleasingTypes = AutoreleasingUnsafeMutablePointer<AnyClass>(types)
        objc_getClassList(autoreleasingTypes, Int32(typeCount))
        print(types)
       
//        var classes = [AnyClass]()
//        for i in 0 ..< actualClassCount {
//            if let currentClass: AnyClass = allClasses[Int(i)] {
//                classes.append(currentClass)
//            }
//        }
//        
//        return classes
    }
    
}


