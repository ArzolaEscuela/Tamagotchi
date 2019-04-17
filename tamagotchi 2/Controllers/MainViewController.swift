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
    @IBOutlet weak var settingsButton: UIButton!
    
    // Top Buttons
    @IBOutlet weak var feedButton: UIButton!
    @IBOutlet weak var lightsButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var healButton: UIButton!
    
    // Bottom Buttons
    @IBOutlet weak var cleanButton: UIButton!
    @IBOutlet weak var scoldButton: UIButton!
    @IBOutlet weak var careButton: UIButton!
    @IBOutlet weak var statusButton: UIButton!
    
    // Status Panel
    @IBOutlet weak var statusPanel: UIView!
    @IBOutlet weak var statusName: UILabel!
    @IBOutlet weak var statusAge: UILabel!
    @IBOutlet weak var statusWeight: UILabel!
    private var statusHungerPanels = [UIImageView]();
    private var StatusHungerPanels : [UIImageView]
    {
        get
        {
            if (statusHungerPanels.count > 0) { return statusHungerPanels; }
            statusHungerPanels.append(statusHunger1);
            statusHungerPanels.append(statusHunger2);
            statusHungerPanels.append(statusHunger3);
            statusHungerPanels.append(statusHunger4);
            statusHungerPanels.append(statusHunger5);
            return statusHungerPanels;
        }
    }
    @IBOutlet weak var statusHunger1: UIImageView!
    @IBOutlet weak var statusHunger2: UIImageView!
    @IBOutlet weak var statusHunger3: UIImageView!
    @IBOutlet weak var statusHunger4: UIImageView!
    @IBOutlet weak var statusHunger5: UIImageView!
    private var statusDisciplinePanels = [UIImageView]();
    private var StatusDisciplinePanels : [UIImageView]
    {
        get
        {
            if (statusDisciplinePanels.count > 0) { return statusDisciplinePanels; }
            statusDisciplinePanels.append(statusDiscipline1);
            statusDisciplinePanels.append(statusDiscipline2);
            statusDisciplinePanels.append(statusDiscipline3);
            statusDisciplinePanels.append(statusDiscipline4);
            statusDisciplinePanels.append(statusDiscipline5);
            return statusDisciplinePanels;
        }
    }
    @IBOutlet weak var statusDiscipline1: UIImageView!
    @IBOutlet weak var statusDiscipline2: UIImageView!
    @IBOutlet weak var statusDiscipline3: UIImageView!
    @IBOutlet weak var statusDiscipline4: UIImageView!
    @IBOutlet weak var statusDiscipline5: UIImageView!
    private var statusHappinessPanels = [UIImageView]();
    private var StatusHappinessPanels : [UIImageView]
    {
        get
        {
            if (statusHappinessPanels.count > 0) { return statusHappinessPanels; }
            statusHappinessPanels.append(statusHappiness1);
            statusHappinessPanels.append(statusHappiness2);
            statusHappinessPanels.append(statusHappiness3);
            statusHappinessPanels.append(statusHappiness4);
            statusHappinessPanels.append(statusHappiness5);
            return statusHappinessPanels;
        }
    }
    @IBOutlet weak var statusHappiness1: UIImageView!
    @IBOutlet weak var statusHappiness2: UIImageView!
    @IBOutlet weak var statusHappiness3: UIImageView!
    @IBOutlet weak var statusHappiness4: UIImageView!
    @IBOutlet weak var statusHappiness5: UIImageView!
    
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
    
    @IBOutlet weak var dayImage: UIImageView!
    @IBOutlet weak var nightImage: UIImageView!
    @IBOutlet weak var nightOverlay: UIView!
    
    private var kirby: KirbyInstance!;
    
    var currentlyActive: SubSections = SubSections.Main;
    
    public func InitializeKirby()
    {
        if (kirby == nil)
        {
            kirby = KirbyInstance(kirbyAnimationsMain, walking, anger, paint, left
            , right, cheer, sleepIntro, sleepLoop, sleepWakeUp, help, helpDone, inhaleIntro, inhaleLoop, inhaleEnd, inhaleEating, EAnimation.Walking);            
        }
        kirby.StartAnimations();
    }
    
    
    override public func viewDidAppear(_ animated: Bool)
    {
        InitializeKirby();
        SetDayNight(true);
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
    
    private func SetDayNight(_ isDay: Bool)
    {
        dayImage.isHidden = !isDay;
        nightImage.isHidden = isDay;
        nightOverlay.isHidden = isDay;
    }
    
    @IBAction func OnLightsButtonPressed(_ sender: Any)
    {
        if (!ShouldEnableSection(SubSections.Lights))
        {
            SetDayNight(true);
            kirby.AttemptToPlayOneshotAnimation(EAnimation.WakeUp);
            delay(bySeconds: AnimationHandler.wakeUpAnimation.AwaitableAnimationDuration, dispatchLevel: .main)
            {
                self.kirby.ViewAnimation(EAnimation.Walking);
            }
            return;
        }
        DisableAllButtonsExcept(lightsButton);
        
        SetDayNight(false);
        kirby.AttemptToPlayOneshotAnimation(EAnimation.SleepIntro);
        delay(bySeconds: AnimationHandler.sleepIntroAnimation.AwaitableAnimationDuration , dispatchLevel: .main)
        {
            self.kirby.ViewAnimation(EAnimation.SleepLoop);
        }
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
        Information.TamagotchiStatus.SetStatusPanels(StatusHungerPanels, KirbyStatus.EStatusBar.Hunger);
        Information.TamagotchiStatus.SetStatusPanels(StatusHappinessPanels, KirbyStatus.EStatusBar.Happiness);
        Information.TamagotchiStatus.SetStatusPanels(StatusDisciplinePanels, KirbyStatus.EStatusBar.Discipline);
        Information.TamagotchiStatus.SetStatus(statusName, statusAge, statusWeight);
        DisableAllPanelsExcept(statusPanel);
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
        SetSinglePanelEnabledState(statusPanel, state);
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
    
    func DoNothing(){}
    
    override func viewDidLoad()
    {
        super.viewDidLoad();
        BackToMainMenu();
        
        //AnimationHandler.walkingAnimation.PlayAnimation(gotchi);
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
