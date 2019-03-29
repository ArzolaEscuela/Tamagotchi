//
//  TitleScreenViewController.swift
//  tamagotchi 2
//
//  Created by alumno on 3/28/19.
//  Copyright © 2019 Diego. All rights reserved.
//

import Foundation
import UIKit

public class TitleScreenViewController : UIViewController
{
        
    @IBOutlet weak var titleScreenGraphic: UIImageView!
    
    override public func viewDidLoad()
    {
        super.viewDidLoad();
        AnimationHandler.walkingAnimation.PlayAnimation(titleScreenGraphic);
    }
}
