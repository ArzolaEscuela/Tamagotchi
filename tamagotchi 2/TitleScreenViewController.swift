import Foundation
import UIKit

public class TitleScreenViewController : UIViewController
{
        
    @IBOutlet weak var tiledBackground: UIImageView!
    @IBOutlet weak var titleScreenGraphic: UIImageView!
    @IBOutlet weak var titleScreenGraphic2: UIImageView!
    
    override public func viewDidLoad()
    {
        super.viewDidLoad();
       
        AnimationHandler.walkingAnimation.PlayAnimation(titleScreenGraphic);
        AnimationHandler.walkingAnimation.PlayAnimation(titleScreenGraphic2);
    }
    
    /*func yourTask() -> Bool
    {
        
    }*/
    
    @IBAction func OnScreenTap(_ sender: Any)
    {
       AnimationHandler.cheerAnimation.PlayAnimation(titleScreenGraphic);
       AnimationHandler.cheerAnimation.PlayAnimation(titleScreenGraphic2);
       
        /*let timer = Timer.scheduledTimer(
            timeInterval: 0.1, target: self, selector: #selector(yourTask),
            userInfo: nil, repeats: true)*/
        
        sleep(4);
        
        
       performSegue(withIdentifier: Information.segueNames.fromTitleToMain, sender: nil);
    }
    
    override open var shouldAutorotate: Bool
    {
        return false
    }
}
