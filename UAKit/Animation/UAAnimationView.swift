//
//  UAAnimationView.swift
//  UAKitBase
//
//  Created by ZD on 2020/4/13.
//  Copyright © 2020 ZD. All rights reserved.
//

import UIKit
import Lottie

/// 对 Lottie 默认缓存 10 个
open class UALottie {
    
    public private(set) var animationView: AnimationView?
        = nil
        
    public init(_ name: String,
    bundle: Bundle = Bundle.main,
    subdirectory: String? = nil,
    animationCache: AnimationCacheProvider? = nil) {
        if let animation = Animation.named(name, bundle: bundle, subdirectory: subdirectory, animationCache: animationCache ?? UALottieCache.shared as AnimationCacheProvider) {
          animationView = AnimationView()
          animationView?.animation = animation
            animationView?.loopMode = .loop
        } else {
            UALog("找不到动画:\(name)")
        }
    }
    
    public func setMode(_ loopMode: LottieLoopMode) {
        animationView?.loopMode = loopMode
    }
    
}

open class UALottieCache: AnimationCacheProvider {
    static let shared = UALottieCache()
    private lazy var cache: NSCache<AnyObject, Animation> = {
        let obj = NSCache<AnyObject, Animation>()
        obj.countLimit = 10
        return obj
    }()
    open func animation(forKey: String) -> Animation? {
        return cache.object(forKey: forKey as AnyObject)
    }
    
    open func setAnimation(_ animation: Animation, forKey: String) {
        cache.setObject(animation, forKey: forKey as AnyObject)
    }
    
    open func clearCache() {
        cache.removeAllObjects()
    }
}

