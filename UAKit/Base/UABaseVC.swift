//
//  SPBaseVC.swift
//  SimilarPro
//
//  Created by ZD on 2020/2/25.
//  Copyright © 2020 ZD. All rights reserved.
//

import UIKit

public protocol UABaseVCProtocol: NSObjectProtocol {
    func setupVM()
    func setupData()
    func setupTable()
    func setupUI()
    func setupLayout()
    func setupActions()
}

public protocol UATableProtocol {
    var table: Table! { get set }
    var data: [TableCellModel] { get set }
}

class UABaseVC: UIViewController, UABaseVCProtocol, UATableProtocol {
    
    public var table: Table!
    public var data: [TableCellModel] = []
    public var backBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        backBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 40))
        backBtn.contentHorizontalAlignment = .left
        let bundle = Bundle(for: UABaseVC.self)
        if let url = bundle.url(forResource: "base", withExtension: "bundle"), let imageBundle = Bundle(url: url) {
            let image = UIImage(contentsOfFile: imageBundle.path(forResource: "nav_back@2x", ofType: "png") ?? "")
            backBtn.setImage(image, for: .normal)
        }
        backBtn.addTarget(self, action: #selector(backBtnAction), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
        
        setupVM()
        setupTable()
        setupUI()
        setupLayout()
        setupActions()
        setupData()
    }
    
    @objc func backBtnAction() {
        navigationController?.popViewController(animated: true)
    }
    
    open func setupVM() {
        
    }
    
    open func setupData() {
        
    }
    
    open func setupTable() {
        table = Table(frame: UIScreen.main.bounds, style: .grouped)
        view.addSubview(table)
    }
    
    open func setupUI() {
        
    }
   
    open func setupLayout() {
        
    }
    
    open func setupActions() {
        
    }

}

extension UABaseVC {
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
}

//extension UABaseVC: UIGestureRecognizerDelegate {
//
//    open func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        return true
//    }
//
//    open func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
////        if gestureRecognizer == self.navigationController?.interactivePopGestureRecognizer {
////            if (self.navigationController?.viewControllers.count ?? 0) < 2 || self.navigationController?.visibleViewController == self.navigationController?.viewControllers[0] {
////                return false
////            }
////        }
//        return true
//    }
//
//    open func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
////        return !gestureRecognizer.isKind(of: UIScreenEdgePanGestureRecognizer.self)
//        return false
//    }
//}
