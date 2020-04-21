//
//  UAWebVC.swift
//  UAKitBase
//
//  Created by ZD on 2020/4/3.
//  Copyright © 2020 ZD. All rights reserved.
//

import UIKit
import WebKit

class UAWebVC: UIViewController {
    
    var urlStr: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        let webV = WKWebView(frame: CGRect.zero)
        view.addSubview(webV)
        
        webV.snp.makeConstraints { (snp) in
            snp.edges.equalToSuperview()
        }
        guard let url = URL(string: urlStr) else { return  }
        webV.load(URLRequest(url: url))
    }

}
