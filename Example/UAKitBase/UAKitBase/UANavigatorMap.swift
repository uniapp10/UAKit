//
//  UANavigatorMap.swift
//  UAKitBase
//
//  Created by ZD on 2020/4/3.
//  Copyright © 2020 ZD. All rights reserved.
//

import Foundation
import URLNavigator
import UAKit

let navigator = Navigator()
struct UANavigatorMap {
    static func initialize(navigator: NavigatorType) {
        let webVCHandler: ViewControllerFactory = {
            (url, values, context) -> UIViewController? in
            UALog(url)
            let webVC = UAWebVC()
            webVC.urlStr = url.urlStringValue
            return webVC
        }
        navigator.register("https://github.com/uniapp10/<path>", webVCHandler)
        navigator.handle("https://github.com/uniapp10") { (url, values, context) -> Bool in
            UALog(url)
            UALog(values)
            UALog(context)
            return true
        }
        navigator.register("https://api.github.com/users/uniapp10/repos") { (url, values, context) -> UIViewController? in
            UALog (url)
            let params = url.queryParameters
            UALog(params)
            let repoVC = UARepoVC()
            repoVC.urlStr = url.urlStringValue
            return repoVC
        }
        
        //默认处理 https,http 对应方法 push
        navigator.register("https://<path:>", webVCHandler)
        navigator.register("http://<path:>", webVCHandler)
        
        //默认处理 https,http 对应方法 open
        navigator.handle("http://<path:>") { (url, values, context) -> Bool in
            UALog(url)
            UALog(values)
            UALog(context)
            return true
        }
        navigator.handle("https://<path:>") { (url, values, context) -> Bool in
            UALog(url)
            UALog(values)
            UALog(context)
            return true
        }
    }
}
