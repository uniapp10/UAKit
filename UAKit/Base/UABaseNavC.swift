//
//  SPBaseNavController.swift
//  SimilarPro
//
//  Created by ZD on 2020/2/25.
//  Copyright © 2020 ZD. All rights reserved.
//

import UIKit

// 开启全局返回手势后，navigationBar 的显示/隐藏需要调用 setNavigationBarHidden 方法
class UABaseNavC: UINavigationController {
    
    var panGesture: UIPanGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.isTranslucent = false
        view.backgroundColor = .white
        navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.font(.PingFang_Regular, size: 18),
                                             NSAttributedString.Key.foregroundColor: UIColor.black]
        
        
        //不建议采用 runtime 方式
//        let tempTarget =  interactivePopGestureRecognizer?.value(forKey: "_targets")
//        guard let targets = (tempTarget as? [NSObject])?.first else {
//            return
//        }
//        let target = targets.value(forKey: "target")
        let target = interactivePopGestureRecognizer?.delegate
        let action = Selector(("handleNavigationTransition:"))
        let targetView = interactivePopGestureRecognizer?.view
        panGesture = UIPanGestureRecognizer(target: target, action: action)
        targetView?.addGestureRecognizer(panGesture)
        panGesture.delegate = self
        //禁用系统手势
        interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = true
        super.pushViewController(viewController, animated: true)
    }
    
}

extension UABaseNavC: UIGestureRecognizerDelegate {
    //多手势会出现页面太灵活问题
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        return true
//    }

    open func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        //处理左滑冲突
        if gestureRecognizer == panGesture {
            let point = (gestureRecognizer as! UIPanGestureRecognizer).translation(in: gestureRecognizer.view)
            if point.x <= 0 {
                return false
            }
        }
        //处理转场冲突
        if let flag = self.value(forKey: "_isTransitioning") as? Bool, flag == true {
            return false
        }
        //处理最后一个 VC
        return viewControllers.count == 1 ? false:true
    }
}


