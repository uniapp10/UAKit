//
//  UATimer.swift
//  UAKitBase
//
//  Created by ZD on 2020/4/21.
//  Copyright © 2020 ZD. All rights reserved.
//

import UIKit

public class UATimer {
    public typealias SwiftTimerHandler = (UATimer)->()

    public let sourceTimer: DispatchSourceTimer
    private var running = false

    public init(deadline: DispatchTime = .now(), repeating interval: DispatchTimeInterval = .never, leeway: DispatchTimeInterval = .nanoseconds(0), handleBlock: SwiftTimerHandler?) {
        sourceTimer = DispatchSource.makeTimerSource()
        sourceTimer.schedule(deadline: deadline, repeating: interval, leeway: leeway)
        sourceTimer.setEventHandler {[weak self] in
            guard let self = self else { return }
            handleBlock?(self)
        }
    }
    
    public func start() {
        sourceTimer.resume()
        running = true
    }
    
    deinit {
        if !running {
            sourceTimer.resume()
        }
    }
}
