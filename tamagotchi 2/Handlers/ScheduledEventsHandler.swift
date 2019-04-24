//
//  ScheduledEventsHandler.swift
//  Tamagotchi
//
//  Created by alumno on 4/20/19.
//  Copyright © 2019 Arzola. All rights reserved.
//

import Foundation

public class ScheduledEvent
{
    private var eventType: KirbyStatus.EKirbyEvent = KirbyStatus.EKirbyEvent.None;
    private var EventType: KirbyStatus.EKirbyEvent { get { return eventType; } }
    
    init(_ eventType: KirbyStatus.EKirbyEvent, _ targetTime: NSDate)
    {
        self.eventType = eventType;
    }
    
}

public class ScheduledAnimationsHandler
{
    public static var events = [ScheduledEvent]();
    private static var scheduledEventTypes = Set<KirbyStatus.EKirbyEvent>();
    private static var timer: Timer!;
    private static var elapsedTime: Int = 0;
    
    init()
    {
        ScheduledAnimationsHandler.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ScheduledAnimationsHandler.OnTick), userInfo: nil, repeats: true);
        NSLog("s");
    }
    
    @objc static func OnTick()
    {
        elapsedTime += 1;
        NSLog(String(elapsedTime));
    }
}
