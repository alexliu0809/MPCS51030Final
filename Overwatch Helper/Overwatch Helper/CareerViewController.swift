//
//  CareerViewController.swift
//  Overwatch Helper
//
//  Created by Enze on 3/6/17.
//  Copyright © 2017 Alex&Ben. All rights reserved.
//

import UIKit

class CareerViewController: UIViewController {

    @IBOutlet weak var careerUsername: UITextField!
    @IBOutlet weak var careerBtn: UIButton!
    
    @IBAction func careerSubmitBtnPressed(_ sender: Any){
        performSegue(withIdentifier: "SeguePlayerStats", sender: sender)
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Career-Bg")!)
        
        //initialize Heros
        HeroIntroController.initializeHeros()
        MapIntroController.initializeMaps() 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "SeguePlayerStats")
        {
            let account = careerUsername.text?.replacingOccurrences(of: "#", with: "-")
            let controller = segue.destination as! PlayerStatController
            controller.playerAccount = account
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
