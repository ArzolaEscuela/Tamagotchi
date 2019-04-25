import UIKit
import GameplayKit

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

enum EVisibleKirby
{
    case StaticKirby;
    case WalkingKirby;
    case ReverseWalkingKirby;
}

class MainViewController: UIViewController
{
    
    @IBOutlet weak var progressLabel: UIOutlinedLabel!
    @IBOutlet weak var walkingKirby: UIImageView!
    @IBOutlet weak var reverseWalkingKirby: UIImageView!
    
    // Top Bar Buttons
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    // Top Buttons
    @IBOutlet weak var feedButton: UIButton!
    @IBOutlet weak var lightsButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var helpButton: UIButton!
    
    // Play Panel
    @IBOutlet weak var playPanel: UIView!
    @IBOutlet weak var playName: UIOutlinedLabel!
    @IBOutlet weak var playLeftButton: UIButton!
    @IBOutlet weak var playRightButton: UIButton!
    
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
    @IBOutlet weak var feedName: UIOutlinedLabel!
    @IBOutlet weak var FeedDisclaimerLabel: UILabel!
    @IBOutlet weak var feedNormalFoodButton: UIButton!
    @IBOutlet weak var feedSnackButton: UIButton!
    
    // Mood Icon
    @IBOutlet weak var currentMood: UIImageView!
    
    // Kirby Animations
    @IBOutlet weak var staticKirby: UIView!
    
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
    private var leftTarget: CGFloat!;
    private var rightTarget: CGFloat!;
    private var targetDistance: CGFloat!;
    
    private static var timedEventsHandler : ScheduledEventsHandler = ScheduledEventsHandler();
    var currentlyActive: SubSections = SubSections.Main;
    var nonStaticKirbyNeeded: Bool = true;
    
    private var ScreenWidth: CGFloat {get {return Information.phoneInformation.ScreenWidth;}}
    private var CurrentEvent: KirbyStatus.EKirbyEvent { get { return Information.TamagotchiStatus.CurrentEvent; } }
    private var FullWalkTimer: Double {get { return 2.6; }}
    
    public func InitializeKirby()
    {
        if (kirby == nil)
        {
            kirby = KirbyInstance(staticKirby, walking, anger, paint, left
            , right, cheer, sleepIntro, sleepLoop, sleepWakeUp, help, helpDone, inhaleIntro, inhaleLoop, inhaleEnd, inhaleEating, EAnimation.Walking);            
        }
        kirby.StartAnimations();
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
    
    @IBAction func OnFeedSnackButtonPressed(_ sender: Any)
    {
        
    }
    
    @IBAction func OnFeedNormalFoodButtonPressed(_ sender: Any)
    {
        
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
            nonStaticKirbyNeeded = true;
            delay(bySeconds: AnimationHandler.wakeUpAnimation.AwaitableAnimationDuration, dispatchLevel: .main)
            {
                self.kirby.ViewAnimation(EAnimation.Walking);
                self.AttemptToUpdateForEventAfterTimer(0);
            }
            return;
        }
        DisableAllButtonsExcept(lightsButton);
        
        SetDayNight(false);
        nonStaticKirbyNeeded = false;
        self.AttemptToUpdateForEventAfterTimer(0);
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
        DisableAllPanelsExcept(playPanel);
    }
    
    @IBAction func OnHealButtonPressed(_ sender: Any)
    {
        if (!ShouldEnableSection(SubSections.Heal)) { return; }
        DisableAllButtonsExcept(helpButton);
    }
    
    @IBAction func OnCleanButtonPressed(_ sender: Any)
    {
        if (!ShouldEnableSection(SubSections.Clean)) { return; }
        DisableAllButtonsExcept(cleanButton);
    }
    
    private func SetStatusPanels()
{
    Information.TamagotchiStatus.SetStatusPanels(StatusHungerPanels, KirbyStatus.EStatusBar.Hunger);
    Information.TamagotchiStatus.SetStatusPanels(StatusHappinessPanels, KirbyStatus.EStatusBar.Happiness);
    Information.TamagotchiStatus.SetStatusPanels(StatusDisciplinePanels, KirbyStatus.EStatusBar.Discipline);
        Information.TamagotchiStatus.SetStatus(statusAge, statusWeight);
    }
    
    @IBAction func OnStatusButtonPressed(_ sender: Any)
    {
        if (!ShouldEnableSection(SubSections.Status)) { return; }
        DisableAllButtonsExcept(statusButton);
        DisableAllPanelsExcept(statusPanel);
        SetStatusPanels();
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
        SetSinglePanelEnabledState(playPanel, state);
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
        SetSingleButtonEnabledState(settingsButton, state);
    }
    
    private func SetAllNonTopButtonsEnabledState(_ state: Bool)
    {
        if (!state)
        {
            ActuallySetButtonStates(false);
            return;
        }
        
        switch(Information.TamagotchiStatus.CurrentEvent)
        {
            case KirbyStatus.EKirbyEvent.Hungry:
                SetButtonStates_Hungry(state);
                break;
            case KirbyStatus.EKirbyEvent.Tired:
                SetButtonStates_Tired(state);
                break;
            case KirbyStatus.EKirbyEvent.Painting:
                SetButtonStates_Painting(state);
                break;
            case KirbyStatus.EKirbyEvent.Rebel:
                SetButtonStates_Rebel(state);
                break;
            case KirbyStatus.EKirbyEvent.Stuck:
                SetButtonStates_Stuck(state);
                break;
            default:
                SetButtonStates_Eventless(state);
                break;
        }
    }
    
    private func ActuallySetButtonStates(_ state: Bool)
    {
        SetSingleButtonEnabledState(feedButton, state);
        SetSingleButtonEnabledState(lightsButton, state);
        SetSingleButtonEnabledState(playButton, state);
        SetSingleButtonEnabledState(helpButton, state);
        
        SetSingleButtonEnabledState(cleanButton, state);
        SetSingleButtonEnabledState(statusButton, state);
        SetSingleButtonEnabledState(scoldButton, state);
        SetSingleButtonEnabledState(careButton, state);
    }
    
    private func SetButtonStates_Hungry(_ state: Bool)
    {
        ActuallySetButtonStates(false);
        SetSingleButtonEnabledState(feedButton, true);
    }
    
    private func SetButtonStates_Tired(_ state: Bool)
    {
        ActuallySetButtonStates(false);
        SetSingleButtonEnabledState(lightsButton, true);
    }
    
    private func SetButtonStates_Painting(_ state: Bool)
    {
        ActuallySetButtonStates(false);
        SetSingleButtonEnabledState(cleanButton, true);
    }
    
    private func SetButtonStates_Rebel(_ state: Bool)
    {
        ActuallySetButtonStates(false);
        SetSingleButtonEnabledState(scoldButton, true);
    }
    
    private func SetButtonStates_Stuck(_ state: Bool)
    {
        ActuallySetButtonStates(false);
        SetSingleButtonEnabledState(helpButton, true);
    }
    
    private func SetButtonStates_Eventless(_ state: Bool)
    {
        SetSingleButtonEnabledState(feedButton, state);
        SetSingleButtonEnabledState(lightsButton, state);
        SetSingleButtonEnabledState(playButton, state);
        HandleSpecialStateButton(state, helpButton, KirbyStatus.EKirbyEvent.Stuck);
    
        HandleSpecialStateButton(state, cleanButton, KirbyStatus.EKirbyEvent.Painting);        SetSingleButtonEnabledState(statusButton, state);
        HandleSpecialStateButton(state, scoldButton, KirbyStatus.EKirbyEvent.Rebel);
        HandleSpecialStateButton(state, careButton, KirbyStatus.EKirbyEvent.CareAble);
    }
    
    private func HandleSpecialStateButton(_ requestedState: Bool, _ button: UIButton, _ requiredEvent : KirbyStatus.EKirbyEvent)
    {
        SetSingleButtonEnabledState(button, Information.TamagotchiStatus.CurrentEvent == requiredEvent);
    }
    
    private func PrepareKirby()
    {
        AnimationHandler.walkingAnimation.PlayAnimation(walkingKirby);
        walkingKirby.center.x = leftTarget;
        walkingKirby.startAnimating();
        reverseWalkingKirby.center.x = rightTarget;
        reverseWalkingKirby.startAnimating();
    }
    
    private func AttemptToUpdateForEventAfterTimer(_ timerToResumeAfter: Double)
    {
        delay(bySeconds: timerToResumeAfter, dispatchLevel: .main)
        {
            self.AttemptToUpdateForEvent();
        }
    }
    
    private func GetMovementTimerToEdge(_ goingRight: Bool) -> Double
    {
        let currentPos = staticKirby.center.x;
        let timePerUnit : Double = Double(targetDistance) / FullWalkTimer;
        let remainingDistance : Double = Double(goingRight ? rightTarget - currentPos : currentPos - leftTarget);
        return timePerUnit * remainingDistance;
    }
    
    private func StartMovingKirby()
    {
        UIView.animate(withDuration: self.FullWalkTimer, delay: 0, options: [.repeat], animations:
        {
            self.walkingKirby.center.x =  self.rightTarget;
        }, completion: nil)
        
        UIView.animate(withDuration: self.FullWalkTimer, delay: 0, options: [.repeat], animations:
            {
                self.reverseWalkingKirby.center.x =  self.leftTarget;
        }, completion: nil)
    }
    
    private func PlayedGame(_ choseLeft: Bool)
    {
        BackToMainMenu();
        SetAllNonTopButtonsEnabledState(false);
        
        let wonGame = WonGame();
        let shouldPlayRightAnimation = wonGame && !choseLeft || !wonGame && choseLeft;
        SetStaticKirbyVisibility(true);
        
        if (shouldPlayRightAnimation) { self.kirby.AttemptToPlayOneshotAnimation(EAnimation.Right); }
        else { self.kirby.AttemptToPlayOneshotAnimation(EAnimation.Left); }
        
        delay(bySeconds: AnimationHandler.leftAnimation.AwaitableAnimationDuration, dispatchLevel: .main)
        {
            var timeToWait = AnimationHandler.angryAnimation.AwaitableAnimationDuration;
            if (wonGame)
            {
                timeToWait = AnimationHandler.cheerAnimation.AwaitableAnimationDuration;
                self.kirby.AttemptToPlayOneshotAnimation(EAnimation.Cheer);
            }
            else
            {
                self.kirby.ViewAnimation(EAnimation.Angry);
            }
            
            delay(bySeconds: timeToWait, dispatchLevel: .main)
            {
                self.nonStaticKirbyNeeded = true;
                self.AttemptToUpdateForEventAfterTimer(0);
                self.BackToMainMenu();
            }
        }
    }
    
    @IBAction func OnPlayLeftButtonPressed(_ sender: Any)
    {
        PlayedGame(true);
    }
    
    @IBAction func OnPlayRightButtonPressed(_ sender: Any)
    {
        PlayedGame(false);
    }
    
    private func WonGame() -> Bool
    {
        let wonGame = Int.random(min: 1, max: 100) > 50;
        Information.TamagotchiStatus.PlayedGame(wonGame);
        return wonGame;
    }
    
    private func SetStaticKirbyVisibility(_ isVisible: Bool)
    {
        if (isVisible)
        {
            nonStaticKirbyNeeded = false;
            reverseWalkingKirby.isHidden = true;
            walkingKirby.isHidden = true;
            staticKirby.isHidden = false;
            return;
        }
        nonStaticKirbyNeeded = true;
        AttemptToUpdateForEvent();
    }
    
    private func AttemptToUpdateForEvent()
    {
        UpdateVisibleKirby();
    }
    
    private func UpdateVisibleKirby()
    {
        let currentEvent = CurrentEvent;
        reverseWalkingKirby.isHidden = !nonStaticKirbyNeeded || currentEvent != KirbyStatus.EKirbyEvent.Rebel;
        walkingKirby.isHidden = !nonStaticKirbyNeeded || currentEvent == KirbyStatus.EKirbyEvent.Rebel;
        staticKirby.isHidden = nonStaticKirbyNeeded;
    }
    
    override public func viewWillAppear(_ animated: Bool)
    {
        Information.TamagotchiStatus.PrepareNamedTags(playName, feedName, statusName);
        InitializeKirby();
        SetDayNight(true);
        PrepareKirby();
        SetStatusPanels();
        AttemptToUpdateForEvent();
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad();
        BackToMainMenu();
        let center = walkingKirby.center.x;
        let width = walkingKirby.bounds.size.width;
        leftTarget = center - ScreenWidth/2 - width;
        rightTarget = center + ScreenWidth/2 + width;
        targetDistance = rightTarget - leftTarget;
        //MainViewController.timedEventsHandler = ScheduledAnimationsHandler();
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        StartMovingKirby();
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning();
    }
    
    override open var shouldAutorotate: Bool
    {
        return false;
    }
}
