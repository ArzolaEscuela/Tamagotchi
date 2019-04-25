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
    // UI Elements
    @IBOutlet weak var tapAnywhereText: UITextField!
    @IBOutlet weak var tamagotchiText: UILabel!
    @IBOutlet weak var versionText: UIOutlinedLabel!
        
    // Animations
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
    
    private var ScreenHeight: CGFloat {get {return Information.phoneInformation.ScreenHeight;}}
    
    private func InitializeKirby()
    {
        kirby = KirbyInstance(kirbyAnimationsMain, walking, anger, paint, left
            , right, cheer, sleepIntro, sleepLoop, sleepWakeUp, help, helpDone, inhaleIntro, inhaleLoop, inhaleEnd, inhaleEating, EAnimation.Walking);
        kirby.StartAnimations();
    }
    
    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == Information.segueNames.fromTitleToMain)
        {
            // let target = segue.destination as! MainViewController;
        }
    }
    
    override public func viewWillAppear(_ animated: Bool)
    {
        tapAnywhereText.center.y += ScreenHeight;
        tamagotchiText.center.y -= ScreenHeight;
        versionText.center.y -= ScreenHeight;
        transitioning = false;
        InitializeKirby();
    }
    
    override public func viewDidAppear(_ animated: Bool)
    {
        let animationDurations: Double = 0.35;
        
        delay(bySeconds: animationDurations, dispatchLevel: .main)
        {
            UIView.animate(withDuration: animationDurations)
            {
                self.tamagotchiText.center.y += self.ScreenHeight;
            }
        }
        delay(bySeconds: animationDurations*2, dispatchLevel: .main)
        {
            UIView.animate(withDuration: animationDurations)
            {
                self.versionText.center.y += self.ScreenHeight;
            }
        }
        delay(bySeconds: animationDurations*3, dispatchLevel: .main)
        {
            UIView.animate(withDuration: animationDurations)
            {
                self.tapAnywhereText.center.y -= self.ScreenHeight;
            }
        }
    }
    
    override public func viewDidLoad()
    {
        super.viewDidLoad();
        transitioning = false;
        ScheduledEventsHandler.AttemptToInitialize();
    }
    
    @IBAction func OnScreenTap(_ sender: Any)
    {
        if (transitioning) { return; }
        transitioning = true;
        kirby.AttemptToPlayOneshotAnimation(EAnimation.Cheer);
        delay(bySeconds: AnimationHandler.cheerAnimation.AwaitableAnimationDuration, dispatchLevel: .main)
        {
            self.performSegue(withIdentifier: Information.segueNames.fromTitleToMain, sender: nil);
            self.kirby.ViewAnimation(EAnimation.Walking);
        }
    }
    
    override open var shouldAutorotate: Bool
    {
        return false
    }
}
