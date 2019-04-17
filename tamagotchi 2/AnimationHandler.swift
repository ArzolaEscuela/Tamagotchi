import UIKit
import Foundation

public class Animation
{
    public var Loops : Bool
    {
        get { return loops; }
    }
    
    public var AwaitableAnimationDuration: Double
    {
        get
        {
            return prefferedAnimationDuration + AnimationHandler.animationWaitOffset;/*(prefferedAnimationDuration * 0.75) + AnimationHandler.animationWaitOffset;*/
        }
    }
    
    private var images = [UIImage]()
    private var prefferedAnimationDuration: Double = -1.0;
    private var loops: Bool = true;
    private var finalFrame = UIImage();
    
    init(_ prefferedAnimationDuration: Double, _ animationName: String, _ startFrame: Int, _ endFrame: Int, _ loops: Bool)
    {
        self.loops = loops;
        self.prefferedAnimationDuration = prefferedAnimationDuration;
        
        for i in startFrame...endFrame
        {
            let animationName = animationName + String(i) + ".png";
            images.append(UIImage(named: animationName)!);
        }
        finalFrame = images[self.images.count - 1];
    }
    
    public func TryToPlayOneshotAnimation(_ targetGraphic: UIImageView)
    {
        if (loops) { return; } // If the animation already automatically loops, there is no oneshot functionality supported.
        
        targetGraphic.animationDuration = prefferedAnimationDuration;
        
        targetGraphic.stopAnimating();
        targetGraphic.animationImages = images;
        targetGraphic.animationRepeatCount = 1;
        targetGraphic.startAnimating();
        delay(bySeconds: AwaitableAnimationDuration, dispatchLevel: .main)
        {
            targetGraphic.stopAnimating();
            targetGraphic.image = self.finalFrame;
        }
    }
        
    public func PlayAnimation(_ targetGraphic: UIImageView)
    {
        targetGraphic.animationDuration = prefferedAnimationDuration;
        targetGraphic.animationRepeatCount = Int.max;
        targetGraphic.animationImages = images;
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
    public static var animationWaitOffset: Double = -0.25;
    
    public static var walkingAnimation = Animation(1, "walking", 1, 10, true);
    public static var cheerAnimation = Animation(0.6, "cheer", 1, 10, false);
    public static var paintAnimation = Animation(1, "paint", 1, 5, true);
    public static var leftAnimation = Animation(2, "left", 1, 3, false);
    public static var rightAnimation = Animation(2, "right", 1, 3, false);
    public static var angryAnimation = Animation(3, "angry", 1, 1, true);
    
    public static var sleepIntroAnimation = Animation(0.85, "sleeping", 1, 8, false);
    public static var sleepLoopAnimation = Animation(2, "sleeping", 5, 8, true);
    public static var wakeUpAnimation = Animation(0.8, "sleeping", 9, 13, false);
    
    public static var helpLoopAnimation = Animation(1, "help", 1, 8, true);
    public static var helpEndAnimation = Animation(1, "help", 9, 12, false);
    
    public static var inhaleIntroAnimation = Animation(1, "inhale_eat", 1, 5, false);
    public static var inhaleLoopAnimation = Animation(1, "inhale_eat", 3, 5, true);
    public static var inhaleEndAnimation = Animation(1, "inhale_eat", 6, 9, false);
    public static var eatAnimation = Animation(1, "inhale_eat", 10, 13, false);
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
    
    public func AttemptToPlayOneshotAnimation(_ animation: EAnimation)
    {
        ViewAnimation(animation);
        
        switch animation
        {
        case EAnimation.Walking:  AnimationHandler.walkingAnimation.TryToPlayOneshotAnimation(walking); break;
        case EAnimation.Angry:  AnimationHandler.angryAnimation.TryToPlayOneshotAnimation(angry); break;
        case EAnimation.Paint:  AnimationHandler.paintAnimation.TryToPlayOneshotAnimation(paint); break;
        case EAnimation.Left:  AnimationHandler.leftAnimation.TryToPlayOneshotAnimation(left); break;
        case EAnimation.Right:  AnimationHandler.rightAnimation.TryToPlayOneshotAnimation(right); break;
        case EAnimation.Cheer:  AnimationHandler.cheerAnimation.TryToPlayOneshotAnimation(cheer); break;
            
        case EAnimation.SleepIntro:  AnimationHandler.sleepIntroAnimation.TryToPlayOneshotAnimation(sleepIntro); break;
        case EAnimation.SleepLoop:  AnimationHandler.sleepLoopAnimation.TryToPlayOneshotAnimation(sleepLoop); break;
        case EAnimation.WakeUp:  AnimationHandler.wakeUpAnimation.TryToPlayOneshotAnimation(sleepWakeUp); break;
            
        case EAnimation.HelpLoop:  AnimationHandler.helpLoopAnimation.TryToPlayOneshotAnimation(help); break;
        case EAnimation.HelpEnd:  AnimationHandler.helpEndAnimation.TryToPlayOneshotAnimation(helpDone); break;
            
        case EAnimation.InhaleIntro:  AnimationHandler.inhaleIntroAnimation.TryToPlayOneshotAnimation(inhaleIntro); break;
        case EAnimation.InhaleLoop:  AnimationHandler.inhaleLoopAnimation.TryToPlayOneshotAnimation(inhaleLoop); break;
        case EAnimation.InhaleEnd: AnimationHandler.inhaleEndAnimation.TryToPlayOneshotAnimation(inhaleEnd); break;
        case EAnimation.Eat: AnimationHandler.eatAnimation.TryToPlayOneshotAnimation(inhaleEating); break;
        default: break;
        }
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
        case EAnimation.Walking: walking.isHidden = false;break;
        case EAnimation.Angry: angry.isHidden = false;break;
        case EAnimation.Paint: paint.isHidden = false;break;
        case EAnimation.Left: left.isHidden = false;break;
        case EAnimation.Right: right.isHidden = false;break;
        case EAnimation.Cheer: cheer.isHidden = false;break;
        
        case EAnimation.SleepIntro: sleepIntro.isHidden = false;break;
        case EAnimation.SleepLoop: sleepLoop.isHidden = false;break;
        case EAnimation.WakeUp: sleepWakeUp.isHidden = false;break;
            
        case EAnimation.HelpLoop: help.isHidden = false;break;
        case EAnimation.HelpEnd: helpDone.isHidden = false;break;
            
        case EAnimation.InhaleIntro: inhaleIntro.isHidden = false;break;
        case EAnimation.InhaleLoop: inhaleLoop.isHidden = false;break;
        case EAnimation.InhaleEnd: inhaleEnd.isHidden = false;break;
        case EAnimation.Eat: inhaleEating.isHidden = false;break;
        default: break;
        }
    }
    
    public func StartAnimations()
    {
        if (AnimationHandler.walkingAnimation.Loops)
        {walking.startAnimating();}
        if (AnimationHandler.angryAnimation.Loops)
        {angry.startAnimating();}
        if (AnimationHandler.paintAnimation.Loops)
        {paint.startAnimating();}
        if (AnimationHandler.leftAnimation.Loops)
        {left.startAnimating();}
        if (AnimationHandler.rightAnimation.Loops)
        {right.startAnimating();}
        if (AnimationHandler.cheerAnimation.Loops)
        {cheer.startAnimating();}
        if (AnimationHandler.sleepIntroAnimation.Loops)
        {sleepIntro.startAnimating();}
        if (AnimationHandler.sleepLoopAnimation.Loops)
        {sleepLoop.startAnimating();}
        if (AnimationHandler.wakeUpAnimation.Loops)
        {sleepWakeUp.startAnimating();}
        if (AnimationHandler.helpLoopAnimation.Loops)
        {help.startAnimating();}
        if (AnimationHandler.helpEndAnimation.Loops)
        {helpDone.startAnimating();}
        if (AnimationHandler.inhaleIntroAnimation.Loops)
        {inhaleIntro.startAnimating();}
        if (AnimationHandler.inhaleLoopAnimation.Loops)
        {inhaleLoop.startAnimating();}
        if (AnimationHandler.eatAnimation.Loops)
        {inhaleEating.startAnimating();}
        if (AnimationHandler.inhaleEndAnimation.Loops)
        {inhaleEnd.startAnimating();}
    }
}
