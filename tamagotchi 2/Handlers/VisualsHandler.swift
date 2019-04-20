//
//  VisualsHandler.swift
//  Tamagotchi
//
//  Created by alumno on 4/16/19.
//  Copyright © 2019 Arzola. All rights reserved.
//

import Foundation
import UIKit

public class ImageReference
{
    private var image = UIImage();
    
    public var Image: UIImage { get { return image; } }
    
    init(_ name: String)
    {
        image = UIImage(named: name)!;
    }
}

public struct VisualsHandler
{
    // Status Panel Icons - Hunger
    private static var statusHungerEmpty = ImageReference("hunger_empty.png");
    public static var StatusHungerEmpty: UIImage { get { return statusHungerEmpty.Image; } }
    private static var statusHungerHalf = ImageReference("hunger_half.png");
    public static var StatusHungerHalf: UIImage { get { return statusHungerHalf.Image; } }
    private static var statusHungerFull = ImageReference("hunger.png");
    public static var StatusHungerFull: UIImage { get { return statusHungerFull.Image; } }
    
    // Status Panel Icons - Discipline
    private static var statusDisciplineEmpty = ImageReference("discipline_empty.png");
    public static var StatusDisciplineEmpty: UIImage { get { return statusDisciplineEmpty.Image; } }
    private static var statusDisciplineHalf = ImageReference("discipline_half.png");
    public static var StatusDisciplineHalf: UIImage { get { return statusDisciplineHalf.Image; } }
    private static var statusDisciplineFull = ImageReference("discipline.png");
    public static var StatusDisciplineFull: UIImage { get { return statusDisciplineFull.Image; } }
    
    // Status Panel Icons - Happiness
    private static var statusHappinessEmpty = ImageReference("happiness_empty.png");
    public static var StatusHappinessEmpty: UIImage { get { return statusHappinessEmpty.Image; } }
    private static var statusHappinessHalf = ImageReference("happiness_half.png");
    public static var StatusHappinessHalf: UIImage { get { return statusHappinessHalf.Image; } }
    private static var statusHappinessFull = ImageReference("happiness.png");
    public static var StatusHappinessFull: UIImage { get { return statusHappinessFull.Image; } }
    
    // Status Circle Graphic
    private static var statusHappy = ImageReference("happy.png");
    public static var StatusHappy: UIImage { get { return statusHappy.Image; } }
    private static var statusNormal = ImageReference("normal.png");
    public static var StatusNormal: UIImage { get { return statusNormal.Image; } }
    private static var statusSad = ImageReference("sad.png");
    public static var StatusSad: UIImage { get { return statusSad.Image; } }
}
