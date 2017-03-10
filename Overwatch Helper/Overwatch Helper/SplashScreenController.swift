//
//  SplashScreenController.swift
//  Overwatch Helper
//
//  Created by Benyan Gong on 3/10/17.
//  Copyright © 2017 Alex&Ben. All rights reserved.
//

import UIKit

class SplashScreenController: UIViewController {

    @IBOutlet weak var overwatch: UILabel!
    
    @IBOutlet weak var companion: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        companion.alpha = 0
        
        
        DispatchQueue.main.async {
            sleep(2)
            UIView.animate(withDuration: 0.7, animations: {
                self.overwatch.alpha = 0
                self.overwatch.center.y -= 123
                self.companion.alpha = 1
                self.companion.center.y -= 123
                
                
            }, completion: {
                finish in
                sleep(2)
                self.performSegue(withIdentifier: "showMain", sender: self)
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
