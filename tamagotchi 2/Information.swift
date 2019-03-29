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
    public var screenWidth: Float;
    public var screenHeight: Float;
    
    init()
    {
        screenWidth  = Float(UIScreen.main.fixedCoordinateSpace.bounds.width);
        screenHeight = Float(UIScreen.main.fixedCoordinateSpace.bounds.height);
    }
}

public class SegueNames
{
    public final var fromTitleToMain: String = "fromTitleToMain";
    public final var fromMainToTitle: String = "fromMainToTitle";
}

public struct Information
{
    public static var phoneInformation = PhoneInformation();
    public static var segueNames = SegueNames();
}
