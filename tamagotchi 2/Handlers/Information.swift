//
//  Information.swift
//  Tamagotchi
//
//  Created by alumno on 3/28/19.
//  Copyright © 2019 Arzola. All rights reserved.
//

import Foundation
import UIKit

public class PhoneInformation
{
    private var screenWidth: CGFloat;
    public var ScreenWidth: CGFloat { get { return screenWidth; } }
    private var screenHeight: CGFloat;
    public var ScreenHeight: CGFloat { get { return screenHeight; } }
    
    init()
    {
        screenWidth  = UIScreen.main.fixedCoordinateSpace.bounds.width;
        screenHeight = UIScreen.main.fixedCoordinateSpace.bounds.height;
    }
}

public class SegueNames
{
    public final var fromTitleToMain: String = "fromTitleToMain";
    public final var fromMainToTitle: String = "fromMainToTitle";
}

public class KirbyStatus
{
    public enum EKirbyEvent
    {
        case None; // Nothing unusual will happen.
        case Hungry; // Kirby will stop moving until fed
        case Tired; // Kirby will stop moving until slept at least 1 hour.
        case Stuck; // Kirby will remain stuck
        case CareAble; // Similar to normal, nothing unusual will happen, but can be cared for.
        case Painting; // Kirby will stop running, and will instead start painting.
        case Rebel; // While rebel, kirby will go backwards, can be scolded.
    }
    
    public enum EStatus
    {
        case Happy;
        case Normal;
        case Sad;
    }
    
    public enum EStatusBar
    {
        case Hunger;
        case Happiness;
        case Discipline;
    }
    
    private var progress: Int = 0;
    
    private var name: String = "Kirby";
    private var age: Int = 0;
    private var weight: String = "2 oz";
    private var status: EStatus = EStatus.Normal;
    private var currentEvent: EKirbyEvent = EKirbyEvent.None;
    // These will range from 0 to 10
    private var hunger: Int = 5;
    private var happiness: Int = 1;
    private var happinessStep: Int = 0;
    private var discipline: Int = 0;
    private var disciplineStep: Int = 0;
    
    public var Progress: Int { get { return progress; } }
    public var Name: String { get { return name; } }
    public var Age: Int { get { return age; } }
    public var Weight: String { get { return weight; } }
    public var Status: EStatus { get { return status; } }
    public var CurrentEvent: EKirbyEvent { get { return currentEvent; } }
    private(set) public var Hunger: Int
    {
        get { return hunger; }
        set(newValue)
        {
            if (newValue < 0) { hunger = 0; return; }
            if (hunger > MAX_VALUE_PER_STAT) { hunger = MAX_VALUE_PER_STAT; return; }
            hunger = newValue;
        }
    }
    public var Happiness: Int { get { return happiness; } }
    public var Discipline: Int { get { return discipline; } }
    
    private let STEPS_PER_LEVEL: Int = 3;
    private let MAX_VALUE_PER_STAT = 10;
   
    
    private var HappinessStep: Int
    {
        get { return happinessStep; }
        set(newValue)
        {
            if (newValue >= STEPS_PER_LEVEL)
            {
                happinessStep = 0;
                if (happiness < MAX_VALUE_PER_STAT){ happiness += 1; }
                return;
            }
            if (newValue < 0)
            {
                if (happiness > 1) { happiness -= 1; happinessStep = STEPS_PER_LEVEL; return; }
                happinessStep = 0; return;
            }
            happinessStep = newValue;
        }
    }
    
    private var DisciplineStep: Int
    {
        get { return disciplineStep; }
        set(newValue)
        {
            if (newValue >= STEPS_PER_LEVEL)
            {
                disciplineStep = 0;
                if (discipline < MAX_VALUE_PER_STAT){ discipline += 1; }
                return;
            }
            if (newValue < 0)
            {
                if (discipline > 1) { discipline -= 1; disciplineStep = STEPS_PER_LEVEL; return; }
                disciplineStep = 0; return;
            }
            disciplineStep = newValue;
        }
    }
   
    public func ScoldedKirby()
    {
        DisciplineStep += 4;
        HappinessStep -= 2;
    }
    
    public func CaredForKirby()
    {
        HappinessStep += 5;
    }
    
    public func FedKirby(_ fedSnack: Bool)
    {
        if (fedSnack)
        {
            DisciplineStep -= 1;
            HappinessStep += 1;
            Hunger += 1;
            return;
        }
        
        Hunger += 2;
    }
    
    public func PlayedGame(_ wonGame: Bool)
    {
        if (!wonGame) { return; }
        HappinessStep += 1;
    }
    
    public func PrepareNamedTags(_ playNameLabel: UILabel, _ feedNameLabel: UILabel, _ stateNameLabel: UILabel)
    {
        playNameLabel.text = Name;
        feedNameLabel.text = Name;
        stateNameLabel.text = Name;
    }
    
    public func SetStatus(_ ageLabel: UILabel, _ weightLabel: UILabel)
    {
        ageLabel.text = String(Age);
        weightLabel.text = Weight;
    }
    
    public func SetStatusPanels(_ panels: [UIImageView], _ panelsType: EStatusBar)
    {
        var emptyGraphic: UIImage;
        var halfGraphic: UIImage;
        var fullGraphic: UIImage;
        var progress: Int;
        
        switch panelsType
        {
        case EStatusBar.Hunger:
            progress = Hunger;
            emptyGraphic = VisualsHandler.StatusHungerEmpty;
            halfGraphic = VisualsHandler.StatusHungerHalf;
            fullGraphic = VisualsHandler.StatusHungerFull;
            break;
        case EStatusBar.Discipline:
            progress = Discipline;
            emptyGraphic = VisualsHandler.StatusDisciplineEmpty;
            halfGraphic = VisualsHandler.StatusDisciplineHalf;
            fullGraphic = VisualsHandler.StatusDisciplineFull;
            break;
        case EStatusBar.Happiness:
            progress = Happiness;
            emptyGraphic = VisualsHandler.StatusHappinessEmpty;
            halfGraphic = VisualsHandler.StatusHappinessHalf;
            fullGraphic = VisualsHandler.StatusHappinessFull;
            break;
        }
        
        for i in 0...(panels.count-1)
        {
            let panelMinWorth = i * 2;
            let panelMaxWorth = panelMinWorth + 2;
            let graphic: UIImage = progress <= panelMinWorth ? emptyGraphic :
            progress >= panelMaxWorth ? fullGraphic : halfGraphic;
            panels[i].image = graphic;
        }
    }
}

public struct Information
{
    public static var phoneInformation = PhoneInformation();
    public static var segueNames = SegueNames();
    
    private static var kirbyStatus = KirbyStatus();  
    
    public static var TamagotchiStatus : KirbyStatus
    {
        get
        {
            // This is a placeholder that always returns a new status, intended to later plug a save file and return it through here once retrieved.
            return kirbyStatus;
        }
    }
}
