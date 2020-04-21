//
//  UATimerVC.swift
//  UAKitBase
//
//  Created by ZD on 2020/4/21.
//  Copyright © 2020 ZD. All rights reserved.
//

import UIKit
import UAKit

class UATimerVC: UABaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = .green
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
        view.addSubview(leftBtn)
        view.addSubview(rightBtn)
        
        let tableV = UITableView(frame: CGRect(x: 10, y: 400, width: 300, height: 400))
        tableV.dataSource = self
        tableV.delegate = self
        tableV.backgroundColor = .orange
        view.addSubview(tableV)
    }
    
    @objc
    func leftBtnClick() -> Void {
//        _ = self.timer
//        _ = link
        _ = timer_gcd
    }
    
    @objc
    func rightBtnClick() -> Void {
        performSelector(inBackground: #selector(timerBGTest), with: nil)
    }
    
    @objc
    func timerBGTest() {
        print("\(Thread.current)")
        perform(#selector(timerBGAction), with: nil, afterDelay: 2)
        RunLoop.current.run()
    }
    @objc func timerBGAction() {
        print("\(#function)")
    }
    
    @objc func timerAction() {
        print("\(#function)")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        timer?.invalidate()
        timer = nil
    }
    
    @objc func linkAction() {
        print("\(#function)")
    }
    
    deinit {
//        timer?.invalidate()
//        timer = nil
        print("deinit")
    }
    
    lazy var timer: Timer? = {
        let obj = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        return obj
    }()
    
    lazy var link: CADisplayLink = {
        let obj = CADisplayLink(target: self, selector: #selector(linkAction))
        obj.frameInterval = 60
        obj.add(to: RunLoop.current, forMode: .common)
        return obj
    }()
    
    lazy var timer_gcd: UATimer = {
        let obj = UATimer(repeating: DispatchTimeInterval.seconds(1)) { (swifTimer) in
            print("SwiftTimer")
        }
        obj.start()
        return obj
    }()
}

//class SwiftTimer {
//    typealias SwiftTimerHandler = (SwiftTimer)->()
//
//    let sourceTimer: DispatchSourceTimer
//    private var running = false
//
//    init(deadline: DispatchTime = .now(), repeating interval: DispatchTimeInterval = .never, leeway: DispatchTimeInterval = .nanoseconds(0), handleBlock: SwiftTimerHandler?) {
//        sourceTimer = DispatchSource.makeTimerSource()
//        sourceTimer.schedule(deadline: deadline, repeating: interval, leeway: leeway)
//        sourceTimer.setEventHandler {[weak self] in
//            guard let self = self else { return }
//            handleBlock?(self)
//        }
//    }
//
//    func start() {
//        sourceTimer.resume()
//        running = true
//    }
//
//    deinit {
//        if !running {
//            sourceTimer.resume()
//        }
//    }
//}

extension UATimerVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            cell?.textLabel?.text = "\(indexPath.section) \(indexPath.row)"
        }
        return cell!
    }
}
