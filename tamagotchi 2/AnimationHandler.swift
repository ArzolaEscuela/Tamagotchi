import UIKit
import Foundation

public class Animation
{
    public var AnimationDuration: Double { get { return prefferedAnimationDuration; } }
    
    private var images = [UIImage]()
    private var prefferedAnimationDuration: Double = -1.0;
    private var loops: Bool = true;
    
    init(_ prefferedAnimationDuration: Double, _ animationName: String, _ startFrame: Int, _ endFrame: Int, _ loops: Bool)
    {
        self.loops = loops;
        self.prefferedAnimationDuration = prefferedAnimationDuration;
        
        for i in startFrame...endFrame
        {
            let animationName = animationName + String(i) + ".png";
            images.append(UIImage(named: animationName)!);
        }
    }
    
        
    public func PlayAnimation(_ targetGraphic: UIImageView, _ onAnimationEnd: @escaping () -> Void)
    {
        targetGraphic.stopAnimating();
        targetGraphic.animationRepeatCount = loops ? Int.max : 0;        
        targetGraphic.animationImages = images;
        targetGraphic.animationDuration = prefferedAnimationDuration;
        targetGraphic.startAnimatingWithCompletionBlock(block: onAnimationEnd);
    }
}

public struct AnimationHandler
{
    public static var walkingAnimation = Animation(0.8, "walking", 1, 10, true);
    public static var cheerAnimation = Animation(0.4, "cheer", 1, 10, false);
}
