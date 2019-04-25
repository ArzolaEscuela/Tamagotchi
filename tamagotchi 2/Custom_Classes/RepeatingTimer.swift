//
//  RepeatingTimer.swift
//  Tamagotchi
//
//  Created by Ilse Hernandez on 4/25/19.
//  Copyright © 2019 Arzola. All rights reserved.
//

import Foundation

/// RepeatingTimer mimics the API of DispatchSourceTimer but in a way that prevents
/// crashes that occur from calling resume multiple times on a timer that is
/// already resumed (noted by https://github.com/SiftScience/sift-ios/issues/52
class RepeatingTimer {
    
    let timeInterval: TimeInterval
    
    init(timeInterval: TimeInterval) {
        self.timeInterval = timeInterval
    }
    
    private lazy var timer: DispatchSourceTimer =
    {
        let t = DispatchSource.makeTimerSource()
        t.schedule(deadline: .now() + self.timeInterval, repeating: self.timeInterval)
        t.setEventHandler(handler: { [weak self] in
            self?.actionToExecute?()
        })
        return t
    }()
    
    var actionToExecute: (() -> Void)?
    
    private enum State
    {
        case suspended
        case resumed
    }
    
    private var state: State = .suspended
    
    deinit
    {
        timer.setEventHandler {}
        timer.cancel()
        resume()
        actionToExecute = nil
    }
    
    func resume()
    {
        if state == .resumed { return; }
        state = .resumed
        timer.resume()
    }
    
    func suspend()
    {
        if state == .suspended
        {
            return
        }
        state = .suspended
        timer.suspend()
    }
}
