//
//  DiscoverController.swift
//  Overwatch Helper
//
//  Created by Benyan Gong on 3/9/17.
//  Copyright © 2017 Alex&Ben. All rights reserved.
//

import UIKit

class DiscoverController: UIViewController {

    var bgIndex = 1
    var maxBgIndex = 4
    var timer: Timer?
    
    @IBOutlet weak var bgImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        messageInitialize()
//        UIGraphicsBeginImageContext(self.view.frame.size)
//        UIImage(named: "discover-bg")?.draw(in: self.view.bounds)
//        var image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
//        UIGraphicsEndImageContext()
//        self.view.backgroundColor = UIColor(patternImage: image)
        // Do any additional setup after loading the view.
        
        self.bgImageView.image = #imageLiteral(resourceName: "discover-bg")
        timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(changeBG), userInfo: nil, repeats: true)
    
                }
    
    func changeBG(){
        self.bgIndex += 1
        if self.bgIndex > self.maxBgIndex{
            self.bgIndex = 1
        }
        DispatchQueue.main.async {
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .transitionCrossDissolve, animations: {
                self.bgImageView.alpha = 0
            }, completion: {_ in
                self.bgImageView.image = UIImage(named: "discoverBG\(self.bgIndex)")
                UIView.animate(withDuration: 0.5, animations: {
                    self.bgImageView.alpha = 1
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
    
    func messageInitialize(){
        LFGMessage.Messages = [LFGMessage(ID: "McRee", avatar: #imageLiteral(resourceName: "mcgree1"), saying: "Looking for a support GTG. IT'S HIGH NOON!"),LFGMessage(ID: "Winston", avatar: #imageLiteral(resourceName: "winsdom1"), saying: "It was not the plane, but the beauty killed the beast."), LFGMessage(ID: "D.Va", avatar: #imageLiteral(resourceName: "dva1"), saying: "123123123213213213"),LFGMessage(ID: "Reaper", avatar: #imageLiteral(resourceName: "reaper1"), saying: "Die Die Die")]
    }

    
}

