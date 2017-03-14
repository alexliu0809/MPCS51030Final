//
//  CareerViewController.swift
//  Overwatch Helper
//
//  Created by Enze on 3/6/17.
//  Copyright © 2017 Alex&Ben. All rights reserved.
//

import UIKit

class CareerViewController: UIViewController {

    
    /// Username for input
    @IBOutlet weak var careerUsername: UITextField!
    ///Career Search Button
    @IBOutlet weak var careerBtn: UIButton!
    ///Instruction View displaying instruction
    @IBOutlet weak var instruView: UITextView!
    
    
    /// Search for Play stats when clicked
    ///
    /// - Parameter sender: the search button
    @IBAction func careerSubmitBtnPressed(_ sender: Any){
        NSLog("Career Search Button Pressed!")
        performSegue(withIdentifier: "SeguePlayerStats", sender: sender) //perform segue
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        //initialize Heros
        HeroIntroController.initializeHeros()
        
        //initialize maps
        MapIntroController.initializeMaps()
        
        //Initialize Intruction view
        instruView.layer.cornerRadius = 10
        instruView.text = "Media: Latest Overwatch news\n\nDiscover: More functions\n\nCareer: Search player data\n\nHero: Overwatch heros profile\n\nMaps: Overwatch Maps profile"
        instruView.sizeToFit()
        instruView.alpha = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /// Perform segue for detail play stats
    ///
    /// - Parameters:
    ///   - segue: to player stats detail
    ///   - sender: button
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "SeguePlayerStats")
        {
            let account = careerUsername.text?.replacingOccurrences(of: "#", with: "-") //Replay Battle ID with - for api
            let controller = segue.destination as! PlayerStatController
            controller.playerAccount = account //set account for grabbing data
        }
    }
    
    
    /// Display Instruction
    ///
    /// - Parameter sender: instruct button
    @IBAction func instruBtnTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.5, animations: {
            NSLog("Instruction button pressed")
            if self.instruView.alpha == 0{
                self.instruView.alpha = 1 //show
            }
            else{
                self.instruView.alpha = 0//close
            }
        })
        
    }


}
