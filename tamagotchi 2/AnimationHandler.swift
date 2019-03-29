//
//  AnimationHandler.swift
//  tamagotchi 2
//
//  Created by alumno on 3/28/19.
//  Copyright © 2019 Diego. All rights reserved.
//

import UIKit
import Foundation

public class Animation
{
    private var imageNames = [String]()
    private var prefferedAnimationDuration: Double = -1.0;
    private var loops: Bool = true;
    
    init(_ prefferedAnimationDuration: Double, _ animationName: String, _ startFrame: Int, _ endFrame: Int, _ loops: Bool)
    {
        self.loops = loops;
        
        for i in startFrame...endFrame
        {
            imageNames.append(animationName + String(i) + ".png");
        }
    }
    
    public func PlayAnimation(_ targetGraphic: UIImageView)
    {
        var images = [UIImage]();
        for i in 0..<imageNames.count
        {
            images.append(UIImage(named: imageNames[i])!);
        }
        targetGraphic.animationImages = images;
        targetGraphic.animationDuration = prefferedAnimationDuration;
        targetGraphic.startAnimating();
    }
}

public struct AnimationHandler
{
    public static var walkingAnimation = Animation(2.0, "walking", 1, 10, true);
    
    
    
    /*var walkingAnimation = SKTextureAtlas();
    var walkingAnimationArray = [SKTexture]();
    
    public func AnimationHandler()
    {
        walkingAnimation = SKTextureAtlas(named: "Visuals/animations/walking");
        
        for i in 1...walkingAnimation.textureNames.count
        {
            var name = "walking\(i).png";
            walkingAnimationArray.append(SKTexture(imageNamed: name));
        }
    }*/
}
