//
//  SecondVC.swift
//  UAKitBase
//
//  Created by ZD on 2020/3/18.
//  Copyright © 2020 ZD. All rights reserved.
//

import UIKit
import UAKit
import SnapKit

class SecondVC: UABaseVC {
    
    var name:String?
    var age:Int?
    

    override func setupUI() {
        super.setupUI()
        
        view.addSubview(titleL)
        titleL.snp.makeConstraints { (snp) in
            snp.left.right.equalToSuperview()
            snp.top.equalToSuperview().inset(50)
        }
        
        titleL.text = "\(name) + \(age)"
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    
    private lazy var titleL: UILabel = {
        let obj = UILabel()
        obj.font = UIFont.font(.PingFang_Medium, size: 17)
        obj.backgroundColor = .orange
        return obj
    }()
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
