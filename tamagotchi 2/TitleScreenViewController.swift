import Foundation
import UIKit

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
    
    /*private var kirby: KirbyInstance;*/
    
    private func InitializeKirbyInstance()
    {
        /*kirby = KirbyInstance(kirbyAnimationsMain, walking, anger, paint, left
            , right, cheer, sleepIntro, sleepLoop, sleepWakeUp, help, helpDone, inhaleIntro, inhaleLoop, inhaleEnd, inhaleEating, EAnimation.Walking);
        kirby.StartAnimations();*/
    }
    
    private func OnEndAnimationEnded()
    {
        performSegue(withIdentifier: Information.segueNames.fromTitleToMain, sender: nil);
    }
    
    private func OnStartAnimationEnded()
    {
        
    }
    
    private func AnimateKirby(_ start: Bool)
    {
        if (start)
        {
            /*AnimationHandler.walkingAnimation.PlayAnimation(titleScreenGraphic, OnStartAnimationEnded);*/
            //AnimationHandler.walkingAnimation.PlayAnimation(titleScreenGraphic2,OnStartAnimationEnded);
            return;
        }
        
        /*AnimationHandler.cheerAnimation.PlayAnimation(titleScreenGraphic, OnEndAnimationEnded);*/
        //AnimationHandler.cheerAnimation.PlayAnimation(titleScreenGraphic2, OnEndAnimationEnded);
    }
    
    override public func viewDidAppear(_ animated: Bool)
    {
        InitializeKirbyInstance();
        /*titleScreenGraphic2.isHidden = true;
        //titleScreenGraphic.frame.origin.x = 0;
        //titleScreenGraphic2.frame.origin.x = Information.phoneInformation.screenWidth;
        
        titleScreenGraphic.startAnimating();*/
        //titleScreenGraphic2.startAnimating();
    }
    
    override public func viewDidLoad()
    {
        super.viewDidLoad();
        
        //AnimateKirby(true);
    }
    
    
    @IBAction func OnScreenTap(_ sender: Any)
    {
        //AnimateKirby(false);
    }
    
    override open var shouldAutorotate: Bool
    {
        return false
    }
}
