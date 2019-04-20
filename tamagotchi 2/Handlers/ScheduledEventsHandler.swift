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
    
    init(_ eventType: KirbyStatus.EKirbyEvent)
    {
        self.eventType = eventType;
    }
    
}

public struct ScheduledAnimationsHandler
{
    
}
