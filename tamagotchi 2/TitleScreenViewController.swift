import Foundation
import UIKit

public class TitleScreenViewController : UIViewController
{
        
    @IBOutlet weak var tiledBackground: UIImageView!
    @IBOutlet weak var titleScreenGraphic: UIImageView!
    @IBOutlet weak var titleScreenGraphic2: UIImageView!
    
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
            AnimationHandler.walkingAnimation.PlayAnimation(titleScreenGraphic, OnStartAnimationEnded);
            //AnimationHandler.walkingAnimation.PlayAnimation(titleScreenGraphic2,OnStartAnimationEnded);
            return;
        }
        
        AnimationHandler.cheerAnimation.PlayAnimation(titleScreenGraphic, OnEndAnimationEnded);
        //AnimationHandler.cheerAnimation.PlayAnimation(titleScreenGraphic2, OnEndAnimationEnded);
    }
    
    override public func viewDidAppear(_ animated: Bool)
    {
        titleScreenGraphic2.isHidden = true;
        //titleScreenGraphic.frame.origin.x = 0;
        //titleScreenGraphic2.frame.origin.x = Information.phoneInformation.screenWidth;
        
        titleScreenGraphic.startAnimating();
        //titleScreenGraphic2.startAnimating();
    }
    
    override public func viewDidLoad()
    {
        super.viewDidLoad();
        
        AnimateKirby(true);
    }
    
    
    @IBAction func OnScreenTap(_ sender: Any)
    {
        AnimateKirby(false);
    }
    
    override open var shouldAutorotate: Bool
    {
        return false
    }
}
