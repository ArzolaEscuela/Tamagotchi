import Foundation
import UIKit

public func delay(bySeconds seconds: Double, dispatchLevel: DispatchLevel = .main, closure: @escaping () -> Void)
{
    let dispatchTime = DispatchTime.now() + seconds
    dispatchLevel.dispatchQueue.asyncAfter(deadline: dispatchTime, execute: closure)
}

public enum DispatchLevel
{
    case main, userInteractive, userInitiated, utility, background
    var dispatchQueue: DispatchQueue
    {
        switch self
        {
            case .main:                 return DispatchQueue.main
            case .userInteractive:      return DispatchQueue.global(qos: .userInteractive)
            case .userInitiated:        return DispatchQueue.global(qos: .userInitiated)
            case .utility:              return DispatchQueue.global(qos: .utility)
            case .background:           return DispatchQueue.global(qos: .background)
        }
    }
}
public class TitleScreenViewController : UIViewController
{
    @IBOutlet weak var kirbyAnimationsMain: UIView!
    
    @IBOutlet weak var walking: UIImageView!
    @IBOutlet weak var anger: UIImageView!
    @IBOutlet weak var paint: UIImageView!
    @IBOutlet weak var left: UIImageView!
    @IBOutlet weak var right: UIImageView!
    @IBOutlet weak var cheer: UIImageView!
    
    @IBOutlet weak var sleepIntro: UIImageView!
    @IBOutlet weak var sleepLoop: UIImageView!
    @IBOutlet weak var sleepWakeUp: UIImageView!
    
    // Help
    @IBOutlet weak var help: UIImageView!
    @IBOutlet weak var helpDone: UIImageView!
    
    // Inhale
    @IBOutlet weak var inhaleIntro: UIImageView!
    @IBOutlet weak var inhaleLoop: UIImageView!
    @IBOutlet weak var inhaleEating: UIImageView!
    @IBOutlet weak var inhaleEnd: UIImageView!
    
    private var kirby: KirbyInstance!;
    private var transitioning: Bool = false;
    
    private func InitializeKirby()
    {
        kirby = KirbyInstance(kirbyAnimationsMain, walking, anger, paint, left
            , right, cheer, sleepIntro, sleepLoop, sleepWakeUp, help, helpDone, inhaleIntro, inhaleLoop, inhaleEnd, inhaleEating, EAnimation.Walking);
        kirby.StartAnimations();
    }
    
    private func OnStartAnimationEnded()
    {
        
    }
    
    override public func viewDidAppear(_ animated: Bool)
    {
        InitializeKirby();
        transitioning = false;
    }
    
    override public func viewDidLoad()
    {
        super.viewDidLoad();
        transitioning = false;
    }
    
    @IBAction func OnScreenTap(_ sender: Any)
    {
        if (transitioning) { return; }
        transitioning = true;
        kirby.ViewAnimation(EAnimation.Cheer);
        delay(bySeconds: AnimationHandler.walkingAnimation.AnimationDuration/2, dispatchLevel: .main)
        {
            self.kirby.ViewAnimation(EAnimation.Walking);
            self.performSegue(withIdentifier: Information.segueNames.fromTitleToMain, sender: nil);
        }
    }
    
    override open var shouldAutorotate: Bool
    {
        return false
    }
}
