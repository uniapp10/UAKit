//
//  UASplashVC.swift
//  UAKitBase
//
//  Created by ZD on 2020/4/18.
//  Copyright © 2020 ZD. All rights reserved.
//

import UIKit
import UAKit
import SDWebImage

class UASplashVC: UABaseVC {
    var skipBlock:(()->())?
    var schemaBlock:(()->())?
    var duration: Int = 3
    var isNetWork: Bool = false
    
    override func setupUI() {
        super.setupUI()
        
        view.addSubview(imageV)
        view.addSubview(skipBtn)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    
    override func setupLayout() {
        super.setupActions()
        
        imageV.snp.makeConstraints { (snp) in
            snp.edges.equalToSuperview()
        }
        skipBtn.snp.makeConstraints { (snp) in
            snp.top.equalToSuperview().inset(UIScreen.topBarHeight + 20)
            snp.right.equalToSuperview().inset(16)
            snp.width.equalTo(80)
            snp.height.equalTo(30)
        }
    }
    
    override func setupActions() {
        super.setupActions()
                
        imageV.tapAction = { [weak self] in
            guard let self = self else { return }
            self.schemaBlock?()
        }
    }
    
    override func setupData() {
        super.setupData()
        
        GitHub.getSplash("http://127.0.0.1:5000/splash/") { (result) in
            self.isNetWork = true
            switch result {
            case .success(let splash):
                self.showAD(splash)
                break
            case .failure(let error):
                print("\(error)")
                self.skip()
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if !self.isNetWork{
                self.skip()
            }
        }
    }
    
    func showAD(_ splash: Splash) {
        if splash.url.isEmpty {
            skip()
        } else {
            if let img = readImg(splash.url) {
                self.imageV.image = img
                skipBtn.isHidden = false
                _ = timer
            } else {
                DispatchQueue.main.async {
                    SDWebImageManager.shared.loadImage(with: URL(string: splash.url)!, options: .allowInvalidSSLCertificates, progress: nil) { (img, data, error, type, success, url) in
                        if error == nil {
                            self.saveImg(data!, splash.url)
                        }
                    }
                }
                skip()
            }
        }
    }
    
    private func saveImg(_ data: Data, _ toFile: String) {
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let adDir = docDir.appending("/AD")
        
        var isDir: ObjCBool = false
        let res0 = FileManager.default.fileExists(atPath: adDir, isDirectory: &isDir)
        if !(res0 && isDir.boolValue) {
            do {
                try FileManager.default.createDirectory(at: URL(fileURLWithPath: adDir), withIntermediateDirectories: true, attributes: nil)
            } catch let err {
                UALog("\(err)")
            }
        }        
        if let files = FileManager.default.subpaths(atPath: adDir) {
            for file in files {
                if FileManager.default.isDeletableFile(atPath: file){
                    try? FileManager.default.removeItem(atPath: file)
                }
            }
        }
        let fileName = URL(string: toFile)!.lastPathComponent
        let filePath = adDir.appending("/\(fileName)")
        let res = FileManager.default.createFile(atPath: filePath, contents: data, attributes: nil)
        if res {
            UALog("成功")
        }else {
            UALog("失败")
        }
    }
    
    private func readImg(_ file:String) -> UIImage? {
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let fileName = URL(string: file)!.lastPathComponent
        let filePath = docDir.appending("/AD/\(fileName)")
        if FileManager.default.fileExists(atPath: filePath) {
            let img = UIImage(contentsOfFile: filePath)
            return img
        }
        return nil
    }
    
    private func updateTip() {
        duration -= 1
        if duration >= 0 {
            skipBtn.setTitle("跳过 \(duration)s", for: .normal)
        } else {
            skipBlock?()
        }
    }
    
    @objc private func skip() {
        skipBlock?()
    }
    
    lazy var timer: Timer = {
        let obj = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] (timer) in
            guard let self = self else { return }
            self.updateTip()
        }
        RunLoop.current.add(obj, forMode: .common)
        return obj
    }()
    
    lazy var imageV: UIImageView = {
        let obj = UIImageView()
        obj.image = UAAppInfo.shared.getLaunchImage()
        obj.contentMode = .scaleAspectFit
        return obj
    }()

    lazy var skipBtn:UIButton = { [unowned self] in
        let obj = UIButton()
        obj.isHidden = true
        obj.backgroundColor = .gray
        obj.setTitle("跳过 \(self.duration)s", for: .normal)
        obj.layer.cornerRadius = 10
        obj.titleLabel?.font = UIFont.font(.PingFang_Regular, size: 15)
        obj.addTarget(self, action: #selector(skip), for: .touchUpInside)
        return obj
    }()
}
