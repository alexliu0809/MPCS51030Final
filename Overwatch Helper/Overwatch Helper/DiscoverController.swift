//
//  DiscoverController.swift
//  Overwatch Helper
//
//  Created by Benyan Gong on 3/9/17.
//  Copyright © 2017 Alex&Ben. All rights reserved.
//

import UIKit

class DiscoverController: UIViewController {

    /// <#Description#>
    var bgIndex = 2
    
    
    /// <#Description#>
    var maxBgIndex = 7
    
    
    /// <#Description#>
    var timer: Timer?
    
    /// <#Description#>
    @IBOutlet weak var bottomView: UIView!
    
    
    /// <#Description#>
    @IBOutlet weak var bgImageView: UIImageView!
    
    
    /// <#Description#>
    @IBOutlet weak var btn1: UIButton!
    
    
    /// <#Description#>
    @IBOutlet weak var btn2: UIButton!
    
    
    /// <#Description#>
    @IBOutlet weak var btn3: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageInitialize()
//        UIGraphicsBeginImageContext(self.view.frame.size)
//        UIImage(named: "discover-bg")?.draw(in: self.view.bounds)
//        var image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
//        UIGraphicsEndImageContext()
//        self.view.backgroundColor = UIColor(patternImage: image)
        // Do any additional setup after loading the view.
        
        btn3.transform = CGAffineTransform(a: 1, b: 0, c: -0.1, d: 1, tx: 0, ty: 0)
        btn2.transform = CGAffineTransform(a: 1, b: 0, c: -0.1, d: 1, tx: 0, ty: 0)
        btn1.transform = CGAffineTransform(a: 1, b: 0, c: -0.1, d: 1, tx: 0, ty: 0)
        btn3.layer.cornerRadius = 5
        btn2.layer.cornerRadius = 5
        btn1.layer.cornerRadius = 5
        
        self.bgImageView.image = #imageLiteral(resourceName: "discoverBG1")
        timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(changeBG), userInfo: nil, repeats: true)
    
                }
    
    
    /// <#Description#>
    func changeBG(){
        self.bgIndex += 1
        if self.bgIndex > self.maxBgIndex{
            self.bgIndex = 1
        }
        DispatchQueue.main.async {
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .transitionCrossDissolve, animations: {
                self.bgImageView.alpha = 0
                self.bottomView.alpha = 0
            }, completion: {_ in
                self.bgImageView.image = UIImage(named: "discoverBG\(self.bgIndex)")
                UIView.animate(withDuration: 0.5, animations: {
                    self.bgImageView.alpha = 1
                    self.bottomView.alpha = 1
                })
            })
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! DiscoverFunctionController
//        controller.modalPresentationStyle = UIModalPresentationStyle.popover
//        controller.popoverPresentationController!.delegate = self
        
        controller.triggeredBySegue = true
        if segue.identifier == "whatsToday" {
            controller.functionType = .whatsToday
        }else if segue.identifier == "heroRecommend" {
            controller.functionType = .heroRecommend
        }else if segue.identifier == "lookingForGroup"{
            controller.functionType = .lookingForGroup
        }else{
            controller.functionType = .none
        }
    }
    
    
    /// <#Description#>
    func messageInitialize(){
        LFGMessage.Messages = [LFGMessage(ID: "McRee", avatar: #imageLiteral(resourceName: "mcgree1"), saying: "Looking for a support GTG. IT'S HIGH NOON!"),LFGMessage(ID: "Winston", avatar: #imageLiteral(resourceName: "winsdom1"), saying: "It was not the plane, but the beauty killed the beast."), LFGMessage(ID: "D.Va", avatar: #imageLiteral(resourceName: "dva1"), saying: "123123123213213213"),LFGMessage(ID: "Reaper", avatar: #imageLiteral(resourceName: "reaper1"), saying: "Die Die Die")]
    }

    
}

