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
        print("heroRec")
        let survey = HeroRecommendationSurvey()
        let question = UILabel(frame: (CGRect(x: 20, y: 100, width: 200, height: 50)))
        let option1 = UIButton(frame: CGRect(x: 20, y: 160, width: 200, height: 50))
        let option2 = UIButton(frame: CGRect(x: 20, y: 220, width: 200, height: 50))
        let option3 = UIButton(frame: CGRect(x: 20, y: 280, width: 200, height: 50))
        let option4 = UIButton(frame: CGRect(x: 20, y: 340, width: 200, height: 50))
        
        question.text = "question1"
        question.backgroundColor = UIColor.brown
        option1.titleLabel?.text = "Option1"
        option1.setTitle("Option1", for: .normal)
        option1.isEnabled = true
        option1.backgroundColor = UIColor.brown
        option1.tag = 101
        option2.tag = 102
        option3.tag = 103
        option4.tag = 104
        
        option1.addTarget(self, action: #selector(survey.choose1), for: .touchUpInside)
        
        view.addSubview(question)
        view.addSubview(option1)
    }
    
    func lookingForGroup(){
        
    }
    

    func choose(){
        print("choose")
    }
}
