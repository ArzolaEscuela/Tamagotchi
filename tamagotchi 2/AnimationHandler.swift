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
        self.prefferedAnimationDuration = prefferedAnimationDuration;
        
        for i in startFrame...endFrame
        {
            imageNames.append(animationName + String(i) + ".png");
        }
    }
    
    public func PlayAnimation(_ targetGraphic: UIImageView)//, _ onAnimationEnd: () -> Void)
    {
        
        targetGraphic.stopAnimating();
        targetGraphic.animationRepeatCount = loops ? Int.max : 0;
        
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
    public static var walkingAnimation = Animation(0.8, "walking", 1, 10, true);
    public static var cheerAnimation = Animation(0.4, "cheer", 1, 10, false);
}
