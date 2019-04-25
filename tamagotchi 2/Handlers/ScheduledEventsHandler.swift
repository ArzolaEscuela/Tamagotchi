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
    public static let TICK_TIMER: Float = 0.1;
    private static let AUTO_SAVE_TIMER: Float = 60;
    
    public static var events = [ScheduledEvent]();
    private static var scheduledEventTypes = Set<EKirbyEvent>();
    private static var timer: RepeatingTimer!;
    private static var elapsedTime: Float = 0;
        
    public static func AttemptToInitialize()
    {
        if (timer != nil) { return; }
        timer = RepeatingTimer(timeInterval: Double(TICK_TIMER));
        timer.actionToExecute = { OnTick(); }
        timer.resume();
    }
    
    static func OnTick()
    {
        elapsedTime += TICK_TIMER;
        if (elapsedTime > AUTO_SAVE_TIMER) { elapsedTime = 0; Information.SaveProgress(); }
        DispatchQueue.main.async
        {
            Information.TamagotchiStatus.OnTimeTick();
            if (Information.mainViewController != nil) { Information.mainViewController.Update(); }
            if (Information.titleScreenViewController != nil) { Information.titleScreenViewController.Update(); }
        }
    }
}
