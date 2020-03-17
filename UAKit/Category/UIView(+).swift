//
//  UIView(+).swift
//  SimilarPro
//
//  Created by ZD on 2020/2/27.
//  Copyright © 2020 ZD. All rights reserved.
//

import UIKit


var tapActionKey = 100
var tapGestureKey = 101

extension UIView {
    
    typealias TapAction = () -> ()
    var tapAction: TapAction {
        set {
            self.isUserInteractionEnabled = true
            
            objc_setAssociatedObject(self, &tapActionKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            var tapGes = objc_getAssociatedObject(self, &tapGestureKey)
            if tapGes == nil {
                tapGes = UITapGestureRecognizer(target: self, action: #selector(handleTapGetureAction(_:)))
                self.addGestureRecognizer(tapGes as! UIGestureRecognizer)
                objc_setAssociatedObject(self, &tapGestureKey, tapGes, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
        
        get {
            return objc_getAssociatedObject(self, &tapActionKey) as! TapAction
        }
    }
    
    @objc func handleTapGetureAction(_ ges: UITapGestureRecognizer) {
        if ges.state == .recognized {
            self.tapAction()
        }
    }
    
    func removeTapAction() {
        objc_setAssociatedObject(self, &tapActionKey, nil, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        objc_setAssociatedObject(self, &tapGestureKey, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    func vc() -> UIViewController? {
        var responder = self.next
        while let res = responder, !res.isKind(of: UIViewController.self) {
            responder = res.next
        }
        if responder?.isKind(of: UIViewController.self) ?? false {
            return (responder as! UIViewController)
        }
        return nil
    }
}
