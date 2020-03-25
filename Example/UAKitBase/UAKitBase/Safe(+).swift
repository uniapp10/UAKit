//
//  Safe(+).swift
//  Pods-UAKitBase
//
//  Created by ZD on 2020/3/24.
//

import Foundation
import UIKit

class UASafeTool: NSObject {
    
    /// 是否开启代理
    public class func getProxyStatus() -> Bool {
        guard let dict = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as? Dictionary<String, Any> else {
            return false
        }
        if dict[kCFNetworkProxiesHTTPProxy as String] != nil {
            return true
        }
        return false
    }
    
    
    /// 是否越狱
    public class func isJailBroken() -> Bool {
        let jailPaths = ["/Applications/Cydia.app",
                        "/Library/MobileSubstrate/MobileSubstrate.dylib",
                        "/bin/bash",
                        "/usr/sbin/sshd",
                        "/etc/apt"]
        for path in jailPaths {
            if FileManager.default.fileExists(atPath: path) {
                return true
            }
        }
        if UIApplication.shared.canOpenURL(URL(string: "cydia://package/com.example.package")!) {
            return true
        }
        //检查权限
        if FileManager.default.fileExists(atPath: "/User/Applications/") {
            #if DEBUG
            let apps = try? FileManager.default.contentsOfDirectory(atPath: "/User/Applications/")
            print("\(apps ?? [])")
            #endif
            return true
        }
        //检查环境变量
        let env = getenv("DYLD_INSERT_LIBRARIES")
        if env != nil {
            return true
        }
        return false
    }
}
