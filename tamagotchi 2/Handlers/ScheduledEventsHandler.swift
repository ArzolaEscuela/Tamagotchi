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
    private var eventType: EKirbyEvent = EKirbyEvent.None;
    private var EventType: EKirbyEvent { get { return eventType; } }
    
    init(_ eventType: EKirbyEvent, _ targetTime: NSDate)
    {
        self.eventType = eventType;
    }
    
}

public class ScheduledEventsHandler
{
    public static var events = [ScheduledEvent]();
    private static var scheduledEventTypes = Set<EKirbyEvent>();
    private static var timer: RepeatingTimer!;
    private static var elapsedTime: Int = 0;
    
    public static func AttemptToInitialize()
    {
        if (timer == nil)
        {
            timer = RepeatingTimer(timeInterval: 5);
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
        Information.SaveProgress();
    }
}
