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

public class ScheduledEventsHandler
{
    public static var events = [ScheduledEvent]();
    private static var scheduledEventTypes = Set<KirbyStatus.EKirbyEvent>();
    private static var timer: RepeatingTimer!;
    private static var elapsedTime: Int = 0;
    
    public static func AttemptToInitialize()
    {
        if (timer == nil)
        {
            timer = RepeatingTimer(timeInterval: 1);
            timer.actionToExecute =
            {
                OnTick();
            }
            timer.resume();
        }
    }
    
    static func OnTick()
    {
        elapsedTime += 1;
        //NSLog(String(elapsedTime));
    }
}
