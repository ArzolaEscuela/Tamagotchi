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
    
        
    public func PlayAnimation(_ targetGraphic: UIImageView)
    {
        targetGraphic.stopAnimating();
        targetGraphic.animationRepeatCount = loops ? Int.max : 0;        
        targetGraphic.animationImages = images;
        targetGraphic.animationDuration = prefferedAnimationDuration;
        /*targetGraphic.startAnimatingWithCompletionBlock(block: onAnimationEnd);*/
    }
}

public enum ErrorTypes : Error
{
    case InvalidAnimation;
}

public enum EAnimation
{
    case Walking;
    case Cheer;
    case Paint;
    case Left;
    case Right;
    case Angry;
    
    case SleepIntro;
    case SleepLoop;
    case WakeUp;

    case HelpLoop;
    case HelpEnd;
    
    case InhaleIntro;
    case InhaleLoop;
    case InhaleEnd;
    case Eat;
}

public struct AnimationHandler
{
    public static var walkingAnimation = Animation(0.8, "walking", 1, 10, true);
    public static var cheerAnimation = Animation(0.4, "cheer", 1, 10, true);
    public static var paintAnimation = Animation(1, "paint", 1, 5, true);
    public static var leftAnimation = Animation(2, "left", 1, 3, true);
    public static var rightAnimation = Animation(2, "right", 1, 3, true);
    public static var angryAnimation = Animation(3, "angry", 1, 1, true);
    
    public static var sleepIntroAnimation = Animation(1, "sleeping", 1, 8, true);
    public static var sleepLoopAnimation = Animation(0.5, "sleeping", 5, 8, true);
    public static var wakeUpAnimation = Animation(0.8, "sleeping", 9, 13, true);
    
    public static var helpLoopAnimation = Animation(1, "help", 1, 8, true);
    public static var helpEndAnimation = Animation(0.25, "help", 9, 12, true);
    
    public static var inhaleIntroAnimation = Animation(0.5, "inhale_eat", 1, 5, true);
    public static var inhaleLoopAnimation = Animation(0.3, "inhale_eat", 3, 5, true);
    public static var inhaleEndAnimation = Animation(0.4, "inhale_eat", 6, 9, true);
    public static var eatAnimation = Animation(0.4, "inhale_eat", 10, 13, true);
}

public class KirbyInstance
{
    private var kirbyAnimationsMain: UIView!
    
    private var walking: UIImageView!
    private var angry: UIImageView!
    private var paint: UIImageView!
    private var left: UIImageView!
    private var right: UIImageView!
    private var cheer: UIImageView!
    
    private var sleepIntro: UIImageView!
    private var sleepLoop: UIImageView!
    private var sleepWakeUp: UIImageView!
    
    // Help
    private var help: UIImageView!
    private var helpDone: UIImageView!
    
    // Inhale
    private var inhaleIntro: UIImageView!
    private var inhaleLoop: UIImageView!
    private var inhaleEating: UIImageView!
    private var inhaleEnd: UIImageView!
    
    init(_ kirbyAnimationsMain: UIView, _ walking: UIImageView, _ angry: UIImageView, _ paint: UIImageView, _ left: UIImageView, _ right: UIImageView, _ cheer: UIImageView, _ sleepIntro: UIImageView, _ sleepLoop: UIImageView, _ sleepWakeUp: UIImageView, _ help: UIImageView, _ helpDone: UIImageView, _ inhaleIntro: UIImageView, _ inhaleLoop: UIImageView, _ inhaleEnd: UIImageView, _ inhaleEating: UIImageView, _ defaultState: EAnimation)
    {
        self.kirbyAnimationsMain = kirbyAnimationsMain;
        
        self.walking = walking;
        AnimationHandler.walkingAnimation.PlayAnimation(walking);
        self.angry = angry;
        AnimationHandler.angryAnimation.PlayAnimation(angry);
        self.paint = paint;
        AnimationHandler.paintAnimation.PlayAnimation(paint);
        self.left = left;
        AnimationHandler.leftAnimation.PlayAnimation(left);
        self.right = right;
        AnimationHandler.rightAnimation.PlayAnimation(right);
        self.cheer = cheer
        AnimationHandler.cheerAnimation.PlayAnimation(cheer);
        
        self.sleepIntro = sleepIntro;
        AnimationHandler.sleepIntroAnimation.PlayAnimation(sleepIntro);
        self.sleepLoop = sleepLoop;
        AnimationHandler.sleepLoopAnimation.PlayAnimation(sleepLoop);
        self.sleepWakeUp = sleepWakeUp;
        AnimationHandler.wakeUpAnimation.PlayAnimation(sleepWakeUp);
        
        self.help = help;
        AnimationHandler.helpLoopAnimation.PlayAnimation(help);
        self.helpDone = helpDone;
        AnimationHandler.helpEndAnimation.PlayAnimation(helpDone);
        
        self.inhaleIntro = inhaleIntro;
        AnimationHandler.inhaleIntroAnimation.PlayAnimation(inhaleIntro);
        self.inhaleLoop = inhaleLoop;
        AnimationHandler.inhaleLoopAnimation.PlayAnimation(inhaleLoop);
        self.inhaleEnd = inhaleEnd;
        AnimationHandler.inhaleEndAnimation.PlayAnimation(inhaleEnd);
        self.inhaleEating = inhaleEating;
        AnimationHandler.eatAnimation.PlayAnimation(inhaleEating);
        
        ViewAnimation(defaultState);
    }
    
    public func ViewAnimation(_ animation: EAnimation)
    {
        walking.isHidden = true;
        angry.isHidden = true;
        paint.isHidden = true;
        left.isHidden = true;
        right.isHidden = true;
        cheer.isHidden = true;
        sleepIntro.isHidden = true;
        sleepLoop.isHidden = true;
        sleepWakeUp.isHidden = true;
        help.isHidden = true;
        helpDone.isHidden = true;
        inhaleIntro.isHidden = true;
        inhaleLoop.isHidden = true;
        inhaleEnd.isHidden = true;
        inhaleEating.isHidden = true;
        
        switch animation
        {
        case EAnimation.Walking: walking.isHidden = false;
        case EAnimation.Angry: angry.isHidden = false;
        case EAnimation.Paint: paint.isHidden = false;
        case EAnimation.Left: left.isHidden = false;
        case EAnimation.Right: right.isHidden = false;
        case EAnimation.Cheer: cheer.isHidden = false;
        
        case EAnimation.SleepIntro: sleepIntro.isHidden = false;
        case EAnimation.SleepLoop: sleepLoop.isHidden = false;
        case EAnimation.WakeUp: sleepWakeUp.isHidden = false;
            
        case EAnimation.HelpLoop: help.isHidden = false;
        case EAnimation.HelpEnd: helpDone.isHidden = false;
            
        case EAnimation.InhaleIntro: inhaleIntro.isHidden = false;
        case EAnimation.InhaleLoop: inhaleLoop.isHidden = false;
        case EAnimation.InhaleEnd: inhaleEnd.isHidden = false;
        case EAnimation.Eat: inhaleEating.isHidden = false;
        default: break;
        }
    }
    
    public func StartAnimations()
    {
        walking.startAnimating();
        angry.startAnimating();
        paint.startAnimating();
        left.startAnimating();
        right.startAnimating();
        cheer.startAnimating();
        sleepIntro.startAnimating();
        sleepLoop.startAnimating();
        sleepWakeUp.startAnimating();
        help.startAnimating();
        helpDone.startAnimating();
        inhaleIntro.startAnimating();
        inhaleLoop.startAnimating();
        inhaleEating.startAnimating();
        inhaleEnd.startAnimating();
    }
}
