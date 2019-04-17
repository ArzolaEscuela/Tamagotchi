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
    public var screenWidth: CGFloat;
    public var screenHeight: CGFloat;
    
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
        case Sleeping;
        case Playing;
        case Hungry;
        case Tired;
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
    
    private var name: String = "Kirby";
    private var age: Int = 0;
    private var weight: String = "2 oz";
    private var status: EStatus = EStatus.Normal;
    // These will range from 0 to 10
    private var hunger: Int = 10;
    private var happiness: Int = 0;
    private var discipline: Int = 0;
    
    public var Name: String { get { return name; } }
    public var Age: Int { get { return age; } }
    public var Weight: String { get { return weight; } }
    public var Status: EStatus { get { return status; } }
    public var Hunger: Int { get { return hunger; } }
    public var Happiness: Int { get { return happiness; } }
    public var Discipline: Int { get { return discipline; } }
    
    public var IsMoving : Bool { get { return true; } }
    public var LapSpeed : Double { get { return 2; } }
    
    public func SetStatus(_ nameLabel: UILabel, _ ageLabel: UILabel, _ weightLabel: UILabel)
    {
        nameLabel.text = Name;
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
        default: break;
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
    
    /*public func SetKirbyState(_ mainView: MainViewController)
    {
        
    }*/
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
