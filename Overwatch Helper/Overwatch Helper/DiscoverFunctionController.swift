//
//  DiscoverFunctionController.swift
//  Overwatch Helper
//
//  Created by Benyan Gong on 3/9/17.
//  Copyright © 2017 Alex&Ben. All rights reserved.
//

import UIKit

enum functionType{
    case whatsToday
    case heroRecommend
    case lookingForGroup
    case none
}

class DiscoverFunctionController: UIViewController {

    var functionType: functionType = .none
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        switch functionType {
        case .whatsToday:
            self.whatsToday()
        case .heroRecommend:
            self.heroRecommend()
        case .lookingForGroup:
            self.lookingForGroup()
        default: break
        }
    }
    

    func whatsToday(){
        
    }
    
    func heroRecommend(){
        
    }
    
    func lookingForGroup(){
        
    }
    

}
