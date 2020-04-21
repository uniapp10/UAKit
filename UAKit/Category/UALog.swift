//
//  Log.swift
//  UAKitBase
//
//  Created by ZD on 2020/4/3.
//  Copyright © 2020 ZD. All rights reserved.
//

import Foundation

public func UALog(_ args: Any...) {
    
    #if DEBUG
    for arg in args {
        print(arg)
    }    
    #endif
}
