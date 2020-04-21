//
//  AppInfo.swift
//  Pods-UAKitBase
//
//  Created by ZD on 2020/3/24.
//

import Foundation
import UIKit

/// 获取App相关的信息，如版本，启动图，App名称等
class UAAppInfo: NSObject {
    static let shared = UAAppInfo()
    
    public func getVersion() -> String {
        let obj = infoDictionary["CFBundleShortVersionString"] as! String
        return obj
    }
    
    public func getAppName() -> String {
        let obj = infoDictionary["CFBundleName"] as! String
        return obj
    }
    
    public func getBuildVersion() -> String {
        let obj = infoDictionary["CFBundleVersion"] as! String
        return obj
    }
    
    public func getPlatforms() -> String {
        let obj = infoDictionary["CFBundleSupportedPlatforms"] as! String
        return obj
    }
    
    public func getSupportOrientations() -> [String] {
        let obj = infoDictionary["UISupportedInterfaceOrientations"] as! [String]
        return obj
    }
    
    public func getTargetVersion() -> String {
        let obj = infoDictionary["MinimumOSVersion"] as! String
        return obj
    }
    
    public func getLaunchImage() -> UIImage! {
        let viewSize = UIScreen.main.bounds.size
        let direction = "Portrait"//垂直
        var launchImageName = ""
        if let tmpLaunchDicts = infoDictionary["UILaunchImages"] as? [[String:String]] {
            for dict in tmpLaunchDicts {
                if __CGSizeEqualToSize(NSCoder.cgSize(for: dict["UILaunchImageSize"]!), viewSize) && dict["UILaunchImageOrientation"] == direction{
                    launchImageName = dict["UILaunchImageName"]!
                    break
                }
            }
        }
        let image = UIImage(named: launchImageName)
        return image!
    }
    
    public func getIconImage() -> UIImage! {
        var iconName = ""
        if let dict = infoDictionary["CFBundleIcons"] as? [String:Any],
            let iconsArray = dict["CFBundlePrimaryIcon"] as? [String:Any] {
            let icons = iconsArray["CFBundleIconFiles"] as! [String]
            iconName = icons.last!
        }
        let image = UIImage(named: iconName)
        return image!
    }
    
    public func getUUID() -> String? {
        let uuid = UIDevice.current.identifierForVendor
        return uuid?.uuidString
    }
    
    private lazy var infoDictionary: [String:Any] = {
        let obj = Bundle.main.infoDictionary!
        return obj
    }()
    
    
}
