//
//  DiscoverController.swift
//  Overwatch Helper
//
//  Created by Benyan Gong on 3/9/17.
//  Copyright © 2017 Alex&Ben. All rights reserved.
//

import UIKit

class DiscoverController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! DiscoverFunctionController
//        controller.modalPresentationStyle = UIModalPresentationStyle.popover
//        controller.popoverPresentationController!.delegate = self
        
        controller.restart()
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
    
//    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
//        return .none
//    }
   

    
}

//popover style
//extension DiscoverController: UIPopoverPresentationControllerDelegate{
//    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
//        
//    }
//}
