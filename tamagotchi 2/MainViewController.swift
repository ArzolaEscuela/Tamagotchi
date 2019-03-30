import UIKit

enum SubSections
{
    case Settings;
    case Feed;
    case Lights;
    case Play;
    case Heal;
    case Clean;
    case Status;
    case Scold;
    case Care;
    case Main;
}

class MainViewController: UIViewController
{
    
    // Top Bar Buttons
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var changeButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    // Top Buttons
    @IBOutlet weak var feedButton: UIButton!
    @IBOutlet weak var lightsButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var healButton: UIButton!
    
    // Bottom Buttons
    @IBOutlet weak var cleanButton: UIButton!
    @IBOutlet weak var statusButton: UIButton!
    @IBOutlet weak var scoldButton: UIButton!
    @IBOutlet weak var careButton: UIButton!
    
    // Settings Panel
    @IBOutlet weak var settingsPanel: UIView!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var closeSettingsPanelButton: UIButton!
    @IBOutlet weak var loggedAsUsernameLabel: UILabel!
    @IBOutlet weak var pickNewUserButton: UIButton!
    
    // Feed Button
    @IBOutlet weak var feedPanel: UIView!
    @IBOutlet weak var FeedDisclaimerLabel: UILabel!
    @IBOutlet weak var feedNormalFoodButton: UIButton!
    @IBOutlet weak var feedSnackButton: UIButton!
    
    @IBOutlet weak var currentMood: UIImageView!
    @IBOutlet weak var gotchi: UIImageView!
    
    var currentlyActive: SubSections = SubSections.Main;
    
    
    override public func viewDidAppear(_ animated: Bool)
    {
        gotchi.startAnimating();
    }
    
    private func BackToMainMenu()
    {
        // Turn on buttons
        SetTopmostButtonsEnabledState(true);
        SetAllNonTopButtonsEnabledState(true);
        // Turn off panels
        SetAllPanelsEnabledState(false);
        currentlyActive = SubSections.Main;
    }
    
    /** Checks if the provided section should be turned on or not. If it should be, the application status is now that it will be within that section (so proper changes need to be made). If it isnt supposed to be active anymore, it will automatically go back to the main menu.*/
    private func ShouldEnableSection (_ section: SubSections) -> Bool
    {
        if (currentlyActive != section)
        {
            currentlyActive = section;
            return true;
        }
        
        BackToMainMenu();
        return false;
    }
    
    @IBAction func OnSettingButtonPressed(_ sender: Any)
    {
        if (!ShouldEnableSection(SubSections.Settings)) { return; }
        DisableAllButtonsExcept(settingsButton);
        DisableAllPanelsExcept(settingsPanel);
    }
    @IBAction func OnCloseSettingsButtonPressed(_ sender: Any) { OnSettingButtonPressed(sender); }
    
    @IBAction func OnFeedButtonPressed(_ sender: Any)
    {
        if (!ShouldEnableSection(SubSections.Feed)) { return; }
        DisableAllButtonsExcept(feedButton);
        DisableAllPanelsExcept(feedPanel);
    }
    
    @IBAction func OnLightsButtonPressed(_ sender: Any)
    {
        if (!ShouldEnableSection(SubSections.Lights)) { return; }
        DisableAllButtonsExcept(lightsButton);
    }
    
    @IBAction func OnPlayButtonPressed(_ sender: Any)
    {
        if (!ShouldEnableSection(SubSections.Play)) { return; }
        DisableAllButtonsExcept(playButton);
    }
    
    @IBAction func OnHealButtonPressed(_ sender: Any)
    {
        if (!ShouldEnableSection(SubSections.Heal)) { return; }
        DisableAllButtonsExcept(healButton);
    }
    
    @IBAction func OnCleanButtonPressed(_ sender: Any)
    {
        if (!ShouldEnableSection(SubSections.Clean)) { return; }
        DisableAllButtonsExcept(cleanButton);
    }
    
    @IBAction func OnStatusButtonPressed(_ sender: Any)
    {
        if (!ShouldEnableSection(SubSections.Status)) { return; }
        DisableAllButtonsExcept(statusButton);
    }
    
    @IBAction func OnScoldButtonPressed(_ sender: Any)
    {
        if (!ShouldEnableSection(SubSections.Scold)) { return; }
        DisableAllButtonsExcept(scoldButton);
    }
    
    @IBAction func OnCareButtonPressed(_ sender: Any)
    {
        if (!ShouldEnableSection(SubSections.Care)) { return; }
        DisableAllButtonsExcept(careButton);
    }
    
    private func DisableAllPanelsExcept(_ panel: UIView)
    {
        SetAllPanelsEnabledState(false);
        SetSinglePanelEnabledState(panel, true);
    }
    
    private func SetSinglePanelEnabledState(_ panel: UIView, _ newState: Bool)
    {
        panel.isHidden = !newState;
    }
    
    private func SetAllPanelsEnabledState(_ state: Bool)
    {
        SetSinglePanelEnabledState(settingsPanel, state);
        SetSinglePanelEnabledState(feedPanel, state);
    }
    
    private func SetSingleButtonEnabledState(_ button: UIButton, _ newState: Bool)
    {
        button.isEnabled = newState;
    }
    
    private func DisableAllButtonsExcept(_ toLeaveEnabled: UIButton)
    {
        SetAllNonTopButtonsEnabledState(false);
        SetSingleButtonEnabledState(toLeaveEnabled, true);
    }
    
    
    private func SetTopmostButtonsEnabledState(_ state: Bool)
    {
        SetSingleButtonEnabledState(homeButton, state);
        // SetSingleButtonEnabledState(changeButton, state);
        SetSingleButtonEnabledState(settingsButton, state);
    }
    
    private func SetAllNonTopButtonsEnabledState(_ state: Bool)
    {
        SetSingleButtonEnabledState(feedButton, state);
        SetSingleButtonEnabledState(lightsButton, state);
        SetSingleButtonEnabledState(playButton, state);
        SetSingleButtonEnabledState(healButton, state);
        
        SetSingleButtonEnabledState(cleanButton, state);
        SetSingleButtonEnabledState(statusButton, state);
        SetSingleButtonEnabledState(scoldButton, state);
        SetSingleButtonEnabledState(careButton, state);
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad();
        BackToMainMenu();
        
        AnimationHandler.walkingAnimation.PlayAnimation(gotchi);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override open var shouldAutorotate: Bool
    {
        return false
    }
}
