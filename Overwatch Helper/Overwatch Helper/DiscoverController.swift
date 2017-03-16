//
//  DiscoverController.swift
//  Overwatch Helper
//
//  Created by Benyan Gong on 3/9/17.
//  Copyright © 2017 Alex&Ben. All rights reserved.
//

import UIKit


class DiscoverController: UIViewController {
    
    ///This controller change background image every 10s
    /// background image index
    var bgIndex = 2
    
    
    /// maximum background image index
    var maxBgIndex = 7
    
    /// change background timer
    var timer: Timer?
    
    /// padding view
    @IBOutlet weak var bottomView: UIView!
    
    
    /// background image
    @IBOutlet weak var bgImageView: UIImageView!
    
    
    /// function "whats today"
    @IBOutlet weak var btn1: UIButton!
    
    
    /// function "survey"
    @IBOutlet weak var btn2: UIButton!
    
    
    /// function "LFG"
    @IBOutlet weak var btn3: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageInitialize()
        
        //make parallelogram
        btn3.transform = CGAffineTransform(a: 1, b: 0, c: -0.1, d: 1, tx: 0, ty: 0)
        btn2.transform = CGAffineTransform(a: 1, b: 0, c: -0.1, d: 1, tx: 0, ty: 0)
        btn1.transform = CGAffineTransform(a: 1, b: 0, c: -0.1, d: 1, tx: 0, ty: 0)
        btn3.layer.cornerRadius = 5
        btn2.layer.cornerRadius = 5
        btn1.layer.cornerRadius = 5
        
        //change background start
        self.bgImageView.image = #imageLiteral(resourceName: "discoverBG1")
        timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(changeBG), userInfo: nil, repeats: true)
    
                }
    
    
    /// change background
    func changeBG(){
        self.bgIndex += 1
        //loop back
        if self.bgIndex > self.maxBgIndex{
            self.bgIndex = 1
        }
        //fade in/out animation
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
        
        //tell which function user want, set target controller then segue
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
    
    
    /// initialize LFG messages
    func messageInitialize(){
        LFGMessage.Messages = [LFGMessage(ID: "McRee", avatar: #imageLiteral(resourceName: "mcgree1"), saying: "Looking for a support GTG. IT'S HIGH NOON!"),LFGMessage(ID: "Winston", avatar: #imageLiteral(resourceName: "winsdom1"), saying: "It was not the plane, but the beauty killed the beast."), LFGMessage(ID: "D.Va", avatar: #imageLiteral(resourceName: "dva1"), saying: "123123123213213213"),LFGMessage(ID: "Reaper", avatar: #imageLiteral(resourceName: "reaper1"), saying: "Die Die Die")]
    }

    
}

