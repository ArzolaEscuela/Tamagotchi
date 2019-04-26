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

public class MainViewController: UIViewController
{
    // Debug
    @IBOutlet weak var forceHelp: UIButton!
    @IBOutlet weak var forceClean: UIButton!
    @IBOutlet weak var forceScold: UIButton!
    @IBOutlet weak var forceCare: UIButton!
    
    // Walking Kirbies + Progress
    @IBOutlet weak var endButton: UIButton!
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
    
    // Paint Panel
    @IBOutlet weak var paintPanel: UIView!
    
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
    @IBOutlet weak var closeSettingsPanelButton: UIButton!
    
    // Feed Button
    @IBOutlet weak var feedPanel: UIView!
    @IBOutlet weak var feedName: UIOutlinedLabel!
    @IBOutlet weak var FeedDisclaimerLabel: UILabel!
    @IBOutlet weak var feedNormalFoodButton: UIButton!
    @IBOutlet weak var feedSnackButton: UIButton!
    @IBOutlet weak var feedFoodToEat: UIImageView!
    
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
    private var foodPos: CGFloat!;
    private var centerTarget: CGFloat!;
    private var leftTarget: CGFloat!;
    private var rightTarget: CGFloat!;
    private var targetDistance: CGFloat!;
    private var targetPaintPanelOut: CGFloat!;
    private var targetPaintPanelInitial: CGFloat!;
    
    private static var timedEventsHandler : ScheduledEventsHandler = ScheduledEventsHandler();
    var currentlyActive: SubSections = SubSections.Main;
    var nonStaticKirbyNeeded: Bool = true;
    
    private var ScreenWidth: CGFloat {get {return Information.phoneInformation.ScreenWidth;}}
    private var CurrentEvent: EKirbyEvent { get { return Information.TamagotchiStatus.CurrentEvent; } }
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
    
    private func SetAsRunning(_ setAsRunning: Bool)
    {
        Information.TamagotchiStatus.UpdateRunning(setAsRunning);
    }
    
    private func BackToMainMenu(_ setAsRunning: Bool)
    {
        // Turn on buttons
        SetTopmostButtonsEnabledState(true);
        SetAllNonTopButtonsEnabledState(true);
        // Turn off panels
        SetAllPanelsEnabledState(false);
        currentlyActive = SubSections.Main;
        
        if (setAsRunning){SetAsRunning(true);}
        PrepareKirbyInCaseOfEvent();
    }
    
    /** Checks if the provided section should be turned on or not. If it should be, the application status is now that it will be within that section (so proper changes need to be made). If it isnt supposed to be active anymore, it will automatically go back to the main menu.*/
    private func ShouldEnableSection (_ section: SubSections) -> Bool
    {
        if (currentlyActive != section)
        {
            currentlyActive = section;
            return true;
        }
        
        BackToMainMenu(false);
        return false;
    }
    
    @IBAction func OnEndButtonPressed(_ sender: Any)
    {
        let url = NSURL(string: "https://www.youtube.com/watch?v=ynfY6FcBWD8")!;
        UIApplication.shared.openURL(url as URL);
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
    
    private func FedKirby(_ fedSnack: Bool)
    {
        Information.TamagotchiStatus.FedKirby(fedSnack);
        
        BackToMainMenu(false);
        SetAllNonTopButtonsEnabledState(false);
        SetStaticKirbyVisibility(true);
        SetAsRunning(false);
        
        // Prepare Food To Eat
        var foodImage = VisualsHandler.RandomFoodItem;
        if (fedSnack) { foodImage = VisualsHandler.RandomSnackItem; }
        
        feedFoodToEat.center.x = foodPos;
        feedFoodToEat.image = foodImage;
        feedFoodToEat.isHidden = false;
        
        // Start Eating Animation
        kirby.AttemptToPlayOneshotAnimation(EAnimation.InhaleIntro);
        
        delay(bySeconds: AnimationHandler.inhaleIntroAnimation.AwaitableAnimationDuration, dispatchLevel: .main)
        {
            
            // Start Inhale Animation
            let inhaleDuration: Double = 0.6;
            self.kirby.ViewAnimation(EAnimation.InhaleLoop);
            
            // Move food towards kirby
            UIView.animate(withDuration: inhaleDuration, delay: 0, options: [.curveEaseInOut , .allowUserInteraction], animations:
            {
                self.feedFoodToEat.center.x =  self.centerTarget;
            }, completion: nil)
            
            delay(bySeconds: inhaleDuration, dispatchLevel: .main)
            {
                // Finish Inhaling
                self.kirby.AttemptToPlayOneshotAnimation(EAnimation.InhaleEnd);
                self.feedFoodToEat.isHidden = true;
                
                delay(bySeconds: AnimationHandler.inhaleEndAnimation.AwaitableAnimationDuration, dispatchLevel: .main)
                {
                    // Eat
                    self.kirby.AttemptToPlayOneshotAnimation(EAnimation.Eat);
                    
                    delay(bySeconds: AnimationHandler.eatAnimation.AwaitableAnimationDuration, dispatchLevel: .main)
                    {
                        // Cheer
                        self.kirby.AttemptToPlayOneshotAnimation(EAnimation.Cheer);
                        
                        delay(bySeconds: AnimationHandler.cheerAnimation.AwaitableAnimationDuration, dispatchLevel: .main)
                        {
                            self.nonStaticKirbyNeeded = true;
                            self.AttemptToUpdateForEventAfterTimer(0);
                            self.BackToMainMenu(true);
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func OnFeedSnackButtonPressed(_ sender: Any)
    {
        FedKirby(true);
    }
    
    @IBAction func OnFeedNormalFoodButtonPressed(_ sender: Any)
    {
        FedKirby(false);
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
                self.SetAsRunning(true);
            }
            return;
        }
        DisableAllButtonsExcept(lightsButton);
        SetAsRunning(false);
        
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
    
    @IBAction func OnHelpButtonPressed(_ sender: Any)
    {
        BackToMainMenu(false);
        SetAllNonTopButtonsEnabledState(false);
        SetAsRunning(false);
        
        self.kirby.AttemptToPlayOneshotAnimation(EAnimation.HelpEnd);
        
        delay(bySeconds: AnimationHandler.helpEndAnimation.AwaitableAnimationDuration, dispatchLevel: .main)
        {
            
            self.kirby.AttemptToPlayOneshotAnimation(EAnimation.Cheer);

            delay(bySeconds: AnimationHandler.cheerAnimation.AwaitableAnimationDuration, dispatchLevel: .main)
            {
                Information.TamagotchiStatus.HelpedKirby();
                self.nonStaticKirbyNeeded = true;
                self.AttemptToUpdateForEventAfterTimer(0);
                self.BackToMainMenu(true);
            }
        }
    }
    
    @IBAction func OnCleanButtonPressed(_ sender: Any)
    {
        BackToMainMenu(false);
        SetAllNonTopButtonsEnabledState(false);
        SetAsRunning(false);
        
        let totalMoveDuration = AnimationHandler.cheerAnimation.AwaitableAnimationDuration;
        
        UIView.animate(withDuration: totalMoveDuration, delay: 0, options: [.curveEaseInOut , .allowUserInteraction], animations:
        {
                self.paintPanel.center.x =  self.targetPaintPanelOut;
        }, completion: nil)
        
        self.kirby.AttemptToPlayOneshotAnimation(EAnimation.Cheer);
        
        delay(bySeconds: AnimationHandler.cheerAnimation.AwaitableAnimationDuration, dispatchLevel: .main)
        {
            Information.TamagotchiStatus.CleanedKirby();
            self.nonStaticKirbyNeeded = true;
            self.AttemptToUpdateForEventAfterTimer(0);
            self.BackToMainMenu(true);
        }
    }
    
    private func SetStatusPanels()
    {
        Information.TamagotchiStatus.SetStatusPanels(StatusHungerPanels, EStatusBar.Hunger);
        Information.TamagotchiStatus.SetStatusPanels(StatusHappinessPanels, EStatusBar.Happiness);
        Information.TamagotchiStatus.SetStatusPanels(StatusDisciplinePanels, EStatusBar.Discipline);
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
        BackToMainMenu(false);
        SetAllNonTopButtonsEnabledState(false);
        SetAsRunning(false);
        SetStaticKirbyVisibility(true);
        
        self.kirby.ViewAnimation(EAnimation.Angry);
        
        delay(bySeconds: AnimationHandler.angryAnimation.AwaitableAnimationDuration, dispatchLevel: .main)
        {
            Information.TamagotchiStatus.ScoldedKirby();
            self.nonStaticKirbyNeeded = true;
            self.AttemptToUpdateForEventAfterTimer(0);
            self.BackToMainMenu(true);
        }
    }
    
    @IBAction func OnCareButtonPressed(_ sender: Any)
    {
        BackToMainMenu(false);
        SetAllNonTopButtonsEnabledState(false);
        SetAsRunning(false);
        SetStaticKirbyVisibility(true);
        
        self.kirby.AttemptToPlayOneshotAnimation(EAnimation.Cheer);
        
        delay(bySeconds: AnimationHandler.cheerAnimation.AwaitableAnimationDuration - 0.2, dispatchLevel: .main)
        {
            Information.TamagotchiStatus.CaredForKirby();
            self.nonStaticKirbyNeeded = true;
            self.AttemptToUpdateForEventAfterTimer(0);
            self.BackToMainMenu(true);
        }
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
        SetSinglePanelEnabledState(paintPanel, state);
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
            case EKirbyEvent.Hungry:
                SetButtonStates_Hungry(state);
                break;
            case EKirbyEvent.Tired:
                SetButtonStates_Tired(state);
                break;
            case EKirbyEvent.Painting:
                SetButtonStates_Painting(state);
                break;
            case EKirbyEvent.Rebel:
                SetButtonStates_Rebel(state);
                break;
            case EKirbyEvent.Stuck:
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
        let canFeed = Information.TamagotchiStatus.CanFeed;
        SetSingleButtonEnabledState(feedButton, canFeed && state);
        SetSingleButtonEnabledState(lightsButton, state);
        SetSingleButtonEnabledState(playButton, state);
        HandleSpecialStateButton(state, helpButton, EKirbyEvent.Stuck);
    
        HandleSpecialStateButton(state, cleanButton, EKirbyEvent.Painting);
        SetSingleButtonEnabledState(statusButton, state);
        HandleSpecialStateButton(state, scoldButton, EKirbyEvent.Rebel);
        HandleSpecialStateButton(state, careButton, EKirbyEvent.CareAble);
    }
    
    private func HandleSpecialStateButton(_ requestedState: Bool, _ button: UIButton, _ requiredEvent : EKirbyEvent)
    {
        SetSingleButtonEnabledState(button, Information.TamagotchiStatus.CurrentEvent == requiredEvent);
    }
    
    private func PrepareKirby()
    {
        AnimationHandler.walkingAnimation.PlayAnimation(walkingKirby);
        walkingKirby.center.x = leftTarget;
        walkingKirby.startAnimating();
        AnimationHandler.reverseWalkingAnimation.PlayAnimation(reverseWalkingKirby);
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
        BackToMainMenu(false);
        SetAllNonTopButtonsEnabledState(false);
        SetAsRunning(false);
        
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
                self.BackToMainMenu(true);
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
        reverseWalkingKirby.isHidden = !nonStaticKirbyNeeded || currentEvent != EKirbyEvent.Rebel;
        walkingKirby.isHidden = !nonStaticKirbyNeeded || currentEvent == EKirbyEvent.Rebel;
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
        feedFoodToEat.isHidden = true;
        progressLabel.text = "";
        SetClearedGameState();
    }
    
    public func Update()
    {
        Information.TamagotchiStatus.UpdateProgressBar(progressLabel);
        SetClearedGameState();
    }
    
    private func SetClearedGameState()
    {
        let clearedGame = Information.TamagotchiStatus.ClearedGame;
        endButton.isHidden = !clearedGame;
        progressLabel.isHidden = clearedGame;
    }
    
    override public func viewDidLoad()
    {
        super.viewDidLoad();
        BackToMainMenu(false);
        let center = walkingKirby.center.x;
        let width = walkingKirby.bounds.size.width;
        
        foodPos = feedFoodToEat.center.x;
        centerTarget = staticKirby.center.x;
        leftTarget = center - ScreenWidth/2 - width;
        rightTarget = center + ScreenWidth/2 + width;
        targetDistance = rightTarget - leftTarget;
        let paintPanelWidth = paintPanel.bounds.size.width;
        targetPaintPanelInitial = paintPanel.center.x;
        targetPaintPanelOut = targetPaintPanelInitial + ScreenWidth/2 + paintPanelWidth;
    }
    private var afterAppear: Bool = false;
    public override func viewDidAppear(_ animated: Bool)
    {
        StartMovingKirby();
        Information.mainViewController = self;
        afterAppear = true;
        PrepareKirbyInCaseOfEvent();
    }
    
    public override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning();
    }
    
    override open var shouldAutorotate: Bool
    {
        return false;
    }
    
    public func PrepareKirbyInCaseOfEvent()
    {
        if (!afterAppear){return;}
        let currentEvent = Information.TamagotchiStatus.CurrentEvent;
        switch currentEvent
        {
        case EKirbyEvent.Painting:
            SetAllPanelsEnabledState(false);
            paintPanel.center.x = targetPaintPanelInitial;
            SetSinglePanelEnabledState(paintPanel, true);
            SetStaticKirbyVisibility(true);
            kirby.ViewAnimation(EAnimation.Paint);
            return;
        case EKirbyEvent.Stuck:
            SetStaticKirbyVisibility(true);
            kirby.ViewAnimation(EAnimation.HelpLoop);
            return;
        case EKirbyEvent.Rebel:
            SetStaticKirbyVisibility(false);
        default: return;
        }
    }
    
    // Debug
    @IBAction func OnForceHelp(_ sender: Any)
    {
        Information.TamagotchiStatus.Debug_SetCurrentEvent(EKirbyEvent.Stuck);
        OnSettingButtonPressed(self);
        PrepareKirbyInCaseOfEvent();
    }
    @IBAction func OnForceClean(_ sender: Any)
    {
        Information.TamagotchiStatus.Debug_SetCurrentEvent(EKirbyEvent.Painting);
        OnSettingButtonPressed(self);
        PrepareKirbyInCaseOfEvent();
    }
    @IBAction func OnForceScold(_ sender: Any)
    {
        Information.TamagotchiStatus.Debug_SetCurrentEvent(EKirbyEvent.Rebel);
        OnSettingButtonPressed(self);
        PrepareKirbyInCaseOfEvent();
    }
    @IBAction func OnForceCare(_ sender: Any)
    {
        Information.TamagotchiStatus.Debug_SetCurrentEvent(EKirbyEvent.CareAble);
        OnSettingButtonPressed(self);
        PrepareKirbyInCaseOfEvent();
    }
    @IBAction func OnMaxStats(_ sender: Any)
    {
        Information.TamagotchiStatus.Debug_MaxStats();
        OnSettingButtonPressed(self);
    }
    @IBAction func OnAdvanceToNearEnd(_ sender: Any)
    {
        Information.TamagotchiStatus.Debug_GoNearEnd();
        OnSettingButtonPressed(self);
    }
    @IBAction func OnResetAllProgress(_ sender: Any)
    {
        Information.Debug_ResetSaveData();
        SetClearedGameState();
        BackToMainMenu(false);
    }
}
