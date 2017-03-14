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
    
    @IBOutlet weak var instruView: UITextView!
    
    
    @IBAction func careerSubmitBtnPressed(_ sender: Any){
        performSegue(withIdentifier: "SeguePlayerStats", sender: sender)
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Verdana-BoldItalic", size: 20)!]
        
        // Do any additional setup after loading the view.
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Career-Bg")!)
        
        //initialize Heros
        HeroIntroController.initializeHeros()
        MapIntroController.initializeMaps()
        instruView.layer.cornerRadius = 10
        instruView.text = "Media: Latest Overwatch news\n\nDiscover: More functions\n\nCareer: Search player data\n\nHero: Overwatch heros profile\n\nMaps: Overwatch Maps profile"
        instruView.sizeToFit()
        instruView.alpha = 0
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
    @IBAction func instruBtnTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.5, animations: {
            if self.instruView.alpha == 0{
                self.instruView.alpha = 1
            }else{
                self.instruView.alpha = 0
            }
        })
        
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
