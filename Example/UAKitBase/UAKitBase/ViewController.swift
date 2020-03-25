//
//  ViewController.swift
//  UAKitBase
//
//  Created by ZD on 2020/3/17.
//  Copyright © 2020 ZD. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.navigationController?.navigationBar.barTintColor = .green
        // Do any additional setup after loading the view.
        let y: CGFloat = 100
        let m: CGFloat = 30
        let screenSize = UIScreen.main.bounds.size
        let width = (screenSize.width - m * 3) * 0.5
        let leftBtn = UIButton.init(frame: CGRect(x: m, y: y, width: width, height: 50))
        leftBtn.setTitle("test1", for: .normal)
        leftBtn.addTarget(self, action: #selector(leftBtnClick), for: .touchUpInside)
        leftBtn.backgroundColor = .purple
        let rightBtn = UIButton.init(frame: CGRect(x: m * 2 + width, y: y, width: width, height: 50))
        rightBtn.setTitle("test2", for: .normal)
        rightBtn.addTarget(self, action: #selector(rightBtnClick), for: .touchUpInside)
        rightBtn.backgroundColor = .brown
        self.view.addSubview(leftBtn)
        self.view.addSubview(rightBtn)
    }
    
    @objc
    func leftBtnClick() -> Void {
        let vc = ViewController(nibName: nil, bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    func rightBtnClick() -> Void {
                       
//        let res2 = getPorpertyNames(clazz: Person.self)
//        print("\(res2)")
//        let res = getMethodNames(clazz: Person.self)
//        print("\(res)")
//        let secondVC = SecondVC()
//        navigationController?.pushViewController(secondVC, animated: true)
        
//        let secondVC = Person()
//        let res = getMethodNames(clazz: Person.self)
//        print("\(res)")
//        let dict = ["name":"zdd", "age":10] as [String : Any]
//        dict.forEach { (key, value) in
//            if secondVC.isKind(of: Person.self) {
//                if secondVC.responds(to: NSSelectorFromString(key)) {
//                    secondVC.setValue(value, forKey: key)
//                }
//            }
//        }
        
//        Test().foo() // bar new
        UASafeTool.isJailBroken()
//        UAAppInfo.getVerssion()
//        UAAppInfo().getIconImage()
//        UAAppInfo().getLaunchImage()
    }
    
    

}


class Test {
    dynamic func foo() {
        print("bar")
    }
}
extension Test {
    @_dynamicReplacement(for: foo())
    func foo_new() {
        print("bar new")
    }
}

// swift 4.0 以后需要加 @objcMembers 才可以使用 runtime 中的方法
@objcMembers class Person:NSObject {
    var name:String?
    var age: Int?
    func speak(_ name: String) {
        print("\(name)")
    }
    
    class func run() {
        print("run run run")
    }
}

private let swizzlingToken = "swizzlingToken"
extension UIViewController {
    class func initializeMethod() {
        if self != UIViewController.self {
            return
        }
//        var token: dispatch_once_t = 0
//        func test() {
//            dispatch_once(&token) {
//                println("This is printed only on the first call to test()")
//            }
//            println("This is printed for each call to test()")
//        }
//
//        for _ in 0..<4 {
//            test()
//        }
        
    }
}

