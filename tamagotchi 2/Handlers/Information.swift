//
//  Information.swift
//  Tamagotchi
//
//  Created by alumno on 3/28/19.
//  Copyright © 2019 Arzola. All rights reserved.
//

import Foundation
import UIKit
import Parse

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

public enum EKirbyEvent: String, Codable
{
    case None; // Nothing unusual will happen.
    case Hungry; // Kirby will stop moving until fed
    case Tired; // Kirby will stop moving until slept at least 1 hour.
    case Stuck; // Kirby will remain stuck
    case CareAble; // Similar to normal, nothing unusual will happen, but can be cared for.
    case Painting; // Kirby will stop running, and will instead start painting.
    case Rebel; // While rebel, kirby will go backwards, can be scolded.
}

public enum EStatus: String, Codable
{
    case Happy;
    case Normal;
    case Sad;
}

public enum EStatusBar: String, Codable
{
    case Hunger;
    case Happiness;
    case Discipline;
}

public struct KirbyInfo : Codable
{
    var progress: Float = 0;
    var name: String = "Kirby";
    var age: Int = 0;
    var weight: String = "2 oz";
    var status: EStatus = EStatus.Normal;
    var currentEvent: EKirbyEvent = EKirbyEvent.None;
    // These will range from 0 to 10
    var hunger: Int = 5;
    var hungerStep: Int = 0;
    var happiness: Int = 1;
    var happinessStep: Int = 0;
    var discipline: Int = 0;
    var disciplineStep: Int = 0;
}

public class KirbyStatus
{
    private let STEPS_PER_LEVEL: Int = 3;
    private let MAX_VALUE_PER_STAT = 10;
    private let MAX_DISTANCE_POSSIBLE: Float = 999999;
    
    private var info: KirbyInfo!;
    private var isRunning: Bool! = false;
    
    public var Info: KirbyInfo {get {return info;}}
    public var Progress: Float { get { return info.progress; } }
    public var Name: String { get { return info.name; } }
    public var Age: Int { get { return info.age; } }
    public var Weight: String { get { return info.weight; } }
    public var Status: EStatus { get { return info.status; } }
    public var CurrentEvent: EKirbyEvent { get { return info.currentEvent; } }
    public var CanFeed: Bool {get {return info.hunger < MAX_VALUE_PER_STAT; }}
    public var ClearedGame: Bool {get { return info.progress > (MAX_DISTANCE_POSSIBLE-1); } }
    private(set) public var Hunger: Int
    {
        get { return info.hunger; }
        set(newValue)
        {
            if (newValue >= STEPS_PER_LEVEL)
            {
                info.hungerStep = 0;
                if (info.hunger < MAX_VALUE_PER_STAT){ info.hunger += 1; }
                return;
            }
            if (newValue < 0)
            {
                if (info.hunger > 1) { info.hunger -= 1; info.hungerStep = STEPS_PER_LEVEL; return; }
                info.hungerStep = 0; return;
            }
            info.hungerStep = newValue;
        }
    }
    public var Happiness: Int { get { return info.happiness; } }
    public var Discipline: Int { get { return info.discipline; } }
    
    private var HappinessStep: Int
    {
        get { return info.happinessStep; }
        set(newValue)
        {
            if (newValue >= STEPS_PER_LEVEL)
            {
                info.happinessStep = 0;
                if (info.happiness < MAX_VALUE_PER_STAT){ info.happiness += 1; }
                return;
            }
            if (newValue < 0)
            {
                if (info.happiness > 1) { info.happiness -= 1; info.happinessStep = STEPS_PER_LEVEL; return; }
                info.happinessStep = 0; return;
            }
            info.happinessStep = newValue;
        }
    }
    
    private var DisciplineStep: Int
    {
        get { return info.disciplineStep; }
        set(newValue)
        {
            if (newValue >= STEPS_PER_LEVEL)
            {
                info.disciplineStep = 0;
                if (info.discipline < MAX_VALUE_PER_STAT){ info.discipline += 1; }
                return;
            }
            if (newValue < 0)
            {
                if (info.discipline > 1) { info.discipline -= 1; info.disciplineStep = STEPS_PER_LEVEL; return; }
                info.disciplineStep = 0; return;
            }
            info.disciplineStep = newValue;
        }
    }
   
    private var ProgressPerSecond: Float
    {
        get
        {
            let hungerFactor:Float = Float(Hunger+1 / MAX_VALUE_PER_STAT) * 0.1;
            let disciplineFactor:Float = Float(Discipline+1) + Float(info.disciplineStep) / Float(STEPS_PER_LEVEL) * 0.6;
            let happinessFactor:Float = Float(Happiness+1) + Float(info.happinessStep) / Float(STEPS_PER_LEVEL) * 0.3;
            let baseSpeed:Float = Float(Age+1) * 0.5;
            return baseSpeed * hungerFactor * disciplineFactor * happinessFactor;
        }
    }
    private var CurrentEventHaltsKirby: Bool {get { return info.currentEvent == EKirbyEvent.Painting || info.currentEvent == EKirbyEvent.Stuck || info.currentEvent == EKirbyEvent.Tired; } }
    
    init(_ info: KirbyInfo)
    {
        self.info = info;
        isRunning = !CurrentEventHaltsKirby;
    }
    
    public func Debug_SetCurrentEvent(_ newCurrentEvent: EKirbyEvent)
    {
        info.currentEvent = newCurrentEvent;
    }
    
    public func Debug_MaxStats()
    {
        info.hunger = 10;
        info.hungerStep = 0;
        info.discipline = 10;
        info.disciplineStep = 0;
        info.happiness = 10;
        info.happinessStep = 0;
    }
    
    public func Debug_GoNearEnd()
    {
        info.progress = MAX_DISTANCE_POSSIBLE - 10;
    }
    
    public func UpdateProgressBar(_ progressCounter: UILabel)
    {
        let rounded = round(info.progress * 4.0)/4.0;
        progressCounter.text = "Distance Run:" + String(rounded);
    }
    
    public func UpdateRunning(_ isRunning: Bool)
    {
        self.isRunning = isRunning;
    }
    
    public func UpdateKirbyStatusCircle(_ statusCircle: UIImageView)
    {
        switch CurrentEvent
        {
        case EKirbyEvent.Rebel:
            statusCircle.image = VisualsHandler.StatusSad;
            return;
        case EKirbyEvent.Stuck:
            statusCircle.image = VisualsHandler.StatusSad;
            return;
        case EKirbyEvent.Tired:
            statusCircle.image = VisualsHandler.StatusSad;
            return;
        case EKirbyEvent.Hungry:
            statusCircle.image = VisualsHandler.StatusSad;
            return;
        default: break;
        }
        if (Happiness > 8)
        {
            statusCircle.image = VisualsHandler.StatusHappy;
            return;
        }
        statusCircle.image = VisualsHandler.StatusNormal;
    }
    
    public func OnTimeTick()
    {
        var factor: Float = 1;
        if (info.currentEvent == EKirbyEvent.Rebel) { factor = -2.2; }
        if (!isRunning || CurrentEventHaltsKirby) { factor = 0; }
        info.progress += ProgressPerSecond * ScheduledEventsHandler.TICK_TIMER * factor;
        if (info.progress > MAX_DISTANCE_POSSIBLE) { info.progress = MAX_DISTANCE_POSSIBLE; }
        else if (info.progress < 0) {info.progress = 0;}
    }
    
    public func HelpedKirby()
    {
        HappinessStep += 4;
        DisciplineStep += 1;
        FinishedEvent();
    }
    
    public func CleanedKirby()
    {
        DisciplineStep += 4;
        HappinessStep -= 1;
        FinishedEvent();
    }
    
    public func ScoldedKirby()
    {
        DisciplineStep += 4;
        HappinessStep -= 2;
        FinishedEvent();
    }
    
    public func CaredForKirby()
    {
        HappinessStep += 5;
        FinishedEvent();
    }
    
    private func FinishedEvent()
    {
        info.currentEvent = EKirbyEvent.None;
        Information.SaveProgress();
    }
    
    public func FedKirby(_ fedSnack: Bool)
    {
        if (fedSnack)
        {
            self.DisciplineStep -= 1;
            self.HappinessStep += 1;
            self.Hunger += 1;
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
    private static let USER_DEFAULTS_KEY: String = "KirbyGotchiJSON";
    private static let SAVE_FILE_CLASS_NAME = "savefile";
    private static let SAVE_FILE_DATA_COLUMN_NAME = "data";
    private static let SAVE_FILE_DEVICE_ID_COLUMN_NAME = "device";
    
    private static let defaults = UserDefaults.standard;
    private static let jsonEncoder = JSONEncoder()
    private static let jsonDecoder = JSONDecoder();
    
    public static var phoneInformation = PhoneInformation();
    public static var segueNames = SegueNames();
    public static var mainViewController: MainViewController!;
    public static var titleScreenViewController: TitleScreenViewController!;
    private static var kirbyStatus: KirbyStatus!;
    private static var loadedCloudSave: Bool = false;
    
    private static var BrandNewInfo: KirbyInfo { get { return KirbyInfo(); } }
    
    public static func Debug_ResetSaveData()
    {
        kirbyStatus = KirbyStatus(BrandNewInfo);
        SaveProgress();
    }
    
    public static func SaveProgress()
    {
        do
        {
            let jsonData = try jsonEncoder.encode(kirbyStatus.Info);
            let jsonString = String(data: jsonData, encoding: .utf8);
            defaults.set(jsonString, forKey: USER_DEFAULTS_KEY);
            
            let onlineBackup = PFObject(className: SAVE_FILE_CLASS_NAME);
            onlineBackup[SAVE_FILE_DATA_COLUMN_NAME] = jsonString;
            onlineBackup[SAVE_FILE_DEVICE_ID_COLUMN_NAME] = HardwareID;
            onlineBackup.saveInBackground { (success, error) in
                NSLog(error.debugDescription)
            }
        }
        catch { }
    }
    
    private static var SaveExists: Bool { return defaults.object(forKey: USER_DEFAULTS_KEY) != nil; }
    private static var HardwareID: String { return UIDevice.current.identifierForVendor!.uuidString; }
    
    private static func LoadJSONAsData(_ json: String) -> KirbyInfo
    {
        do
        {
            // Decode data to object
            let status = try jsonDecoder.decode(KirbyInfo.self, from: json.data(using: .utf8)!)
            return status;
        } catch { }
        
        NSLog("ERROR: There was an issue while converting \"" + json + "\"")
        return BrandNewInfo;
    }
    
    private static var LocalSave : KirbyStatus
    {
        if (!SaveExists)  { return KirbyStatus(BrandNewInfo); } // If there is no existent file, return a new one.
        let savedJson = defaults.string(forKey: USER_DEFAULTS_KEY);
        return KirbyStatus(LoadJSONAsData(savedJson!));
    }
    
    public static func AttemptToLoadCloudSave()
    {
        if (loadedCloudSave) {return;}
        // We attempt to look for an online save file before anything else.
        let query = PFQuery(className: SAVE_FILE_CLASS_NAME);
        query.whereKey(SAVE_FILE_DEVICE_ID_COLUMN_NAME, equalTo: HardwareID);
        query.findObjectsInBackground { (objects, error) in
            if (error == nil)
            {
                if let returnedObjects = objects
                {
                    for obj in returnedObjects
                    {
                        loadedCloudSave = true;
                        let json = obj[SAVE_FILE_DATA_COLUMN_NAME];
                        kirbyStatus = KirbyStatus(LoadJSONAsData(json! as! String));
                        break;
                    }
                }
            }
        }
        
    }
    
    public static var TamagotchiStatus : KirbyStatus
    {
        get
        {
             // defaults.removeObject(forKey: USER_DEFAULTS_KEY); // This can delete all traces of saved data.
            // This is a placeholder that always returns a new status, intended to later plug a save file and return it through here once retrieved.
            AttemptToLoadCloudSave();
            if (kirbyStatus == nil) { kirbyStatus = LocalSave; SaveProgress(); }
            return kirbyStatus;
        }
    }
}
