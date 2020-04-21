//
//  UAAnimationSVG.swift
//  UAKitBase
//
//  Created by ZD on 2020/4/13.
//  Copyright © 2020 ZD. All rights reserved.
//

import UIKit
import SVGAPlayer
import UAKit

class UAAnimationSVG {

    static func demo1() {
        let svgPlayer = SVGAPlayer(frame: CGRect.zero)
        let parser = SVGAParser()
        parser.parse(with: URL(string: "https://github.com/yyued/SVGA-Samples/blob/master/posche.svga?raw=true")!, completionBlock: { (videoItem) in
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
    
    static func demo2() {
        /*
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
         */
    }

}
