//
//  MainViewController.swift
//  tamagotchi 2
//
//  Created by alumno on 3/21/19.
//  Copyright © 2019 Diego. All rights reserved.
//

import UIKit

class MainViewController: UIViewController
{
    
    //
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var changeButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    //
    @IBOutlet weak var feedButton: UIButton!
    @IBOutlet weak var lightsButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var healButton: UIButton!
    
    //
    @IBOutlet weak var cleanButton: UIButton!
    @IBOutlet weak var statusButton: UIButton!
    @IBOutlet weak var scoldButton: UIButton!
    @IBOutlet weak var careButton: UIButton!
    
    //
    @IBOutlet weak var settingsView: UIView!
    
    
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func OnTap(_ sender: Any)
    {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
