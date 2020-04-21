//
//  UATableVC.swift
//  UAKitBase
//
//  Created by ZD on 2020/4/3.
//  Copyright © 2020 ZD. All rights reserved.
//

import UIKit
import UAKit
import SnapKit
import URLNavigator
import Lottie
import SVGAPlayer


class UATableCell: TableCell {
    override func refresh(data: TableCellModel) {
        super.refresh(data: data)
        
        if let m = data as? UATableM {
            titleL.text = m.title
            subTitleL.text = m.subTitle
        }
    }
    
    override func setupUI() {
        super.setupUI()
        
        [titleL, subTitleL, lineV].forEach { (obj) in
            contentView.addSubview(obj)
        }
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        titleL.snp.makeConstraints { (snp) in
            snp.left.equalTo(16)
            snp.top.equalTo(10)
        }
        subTitleL.snp.makeConstraints { (snp) in
            snp.left.equalTo(16)
            snp.top.equalTo(titleL.snp.bottom).offset(10)
            snp.bottom.equalToSuperview().inset(16)
        }
        lineV.snp.makeConstraints { (snp) in
            snp.left.right.equalToSuperview().inset(16)
            snp.height.equalTo(1)
            snp.bottom.equalToSuperview()
        }
    }
    
    lazy var titleL: UILabel = {
        let obj = UILabel()
        return obj
    }()
    lazy var subTitleL: UILabel = {
        let obj = UILabel()
        obj.font = UIFont.font(.PingFang_Regular, size: 12)
        return obj
    }()
    lazy var lineV: UIView = {
        let obj = UIView()
        obj.backgroundColor = .gray
        return obj
    }()
}

class UATableM: TableCellModel {
    var clazz: String = "UATableCell"
    var height: CGFloat = UITableView.automaticDimension
    var title = ""
    var subTitle = ""
}

class UATableVC: UABaseVC {

    //  varar animationView = AnimationView()
    override func setupUI() {
        super.setupUI()
        
        table.automaticHeight = true
    }
    
    override func setupData() {
        super.setupData()
        
        let data = [["name":"UAKitBase", "url":"https://github.com/uniapp10/UAKit"],
                    ["name":"uniapp10", "url":"https://github.com/uniapp10?tab=repositories"],
                    ["name":"uniapp10Repo","url": "https://api.github.com/users/uniapp10/repos?affiliation=owner&direction=asc&page=1"],
                    ["name":"showLottie","url": ""],
                    ["name":"showSVGA","url": ""],
                    ["name":"showSVGA2","url": ""],
                    ["name":"testTimer","url": ""]]
        let models = data.map { (dict) -> TableCellModel in
            let m = UATableM()
            m.title = dict["name"]!
            m.subTitle = dict["url"]!
            return m
        }
        table.data = [models]
    }
    
    override func setupActions() {
        super.setupActions()
        
        table.action = { [weak self] (action, tableM, position) in
            guard let self = self else { return }
            let model = tableM as! UATableM
            let url = model.subTitle
            switch position!.row {
            case 0:
                let res = navigator.push(url) != nil
                UALog(res)
            case 1:
                let res = navigator.open(url, context: ["a", "b"])
                UALog(res)
            case 2:
                navigator.push(url)
            case 3:
                self.startAnimation()
            case 4:
                self.startSVGAnimation()
            case 5:
                self.startSVGAnimation2()
            case 6:
                self.testTimer()
            default:
                navigator.push(url)
                break
            }
        }
    }
    
    func testTimer() {
        let vc = UATimerVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func startAnimation() {

        let lottie = UALottie("globalLoadingAnimation")
        
        view.addSubview(lottie.animationView!)
        lottie.animationView!.snp.makeConstraints { (snp) in
            snp.center.equalToSuperview()
            snp.width.height.equalTo(100)
        }
        lottie.animationView!.backgroundColor = .gray
        lottie.animationView!.play(fromProgress: 0,
                           toProgress: 1,
                           loopMode: LottieLoopMode.playOnce,
                           completion: { (finished) in
                            if finished {
                              print("Animation Complete")
                               lottie.animationView!.removeFromSuperview()
                            } else {
                              print("Animation cancelled")
                            }
        })
    }
    
    func startSVGAnimation() {
        let svgPlayer = SVGAPlayer(frame: CGRect.zero)
        let parser = SVGAParser()
        self.view.addSubview(svgPlayer)
        svgPlayer.snp.makeConstraints { (snp) in
            snp.center.equalToSuperview()
            snp.width.height.equalTo(100)
        }
        parser.parse(with: URL(string: "https://github.com/yyued/SVGA-Samples/blob/master/kingset.svga?raw=true")!, completionBlock: { (videoItem) in
            if let item = videoItem {
                svgPlayer.videoItem = item
                svgPlayer.startAnimation()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    svgPlayer.removeFromSuperview()
                }
            }
        }) { (error) in
            UALog("xxx:\(error)")
        }
        
    }
    
    func startSVGAnimation2() {
        let svgPlayer = SVGAPlayer(frame: CGRect.zero)
        let parser = SVGAParser()
        self.view.addSubview(svgPlayer)
        svgPlayer.snp.makeConstraints { (snp) in
            snp.center.equalToSuperview()
            snp.width.height.equalTo(350)
        }
        parser.parse(with: URL(string: "https://github.com/yyued/SVGA-Samples/blob/master/kingset.svga?raw=true")!, completionBlock: { (videoItem) in
            if let item = videoItem {
                svgPlayer.videoItem = item
                svgPlayer.startAnimation()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    svgPlayer.setImage(UIImage(named: "tab_attention_selected"), forKey: "99")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        svgPlayer.removeFromSuperview()
                    }
                }
            }
        }) { (error) in
            UALog("xxx:\(error)")
        }
        
    }
//    https://api.github.com/users/uniapp10/repos?affiliation=owner&direction=asc&page=1

}
