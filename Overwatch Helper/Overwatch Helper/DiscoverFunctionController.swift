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

class DiscoverFunctionController: UIViewController, SurveyDelegate, DrawHeroDelegate, UITableViewDelegate, UITableViewDataSource {

    var functionType: functionType = .none
    var survey: HeroRecommendationSurvey?
    var draw: DrawRandomHero?
//    var result: HeroIntroInfo
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        switch functionType {
        case .whatsToday:
            self.draw = DrawRandomHero()
            self.view.addSubview(self.draw!)
            self.draw?.start()
        case .heroRecommend:
            self.survey = HeroRecommendationSurvey()
            self.view.addSubview(survey!)
            survey?.surveyStart()
        default:
            break
        }
        // Do any additional setup after loading the view.
    }
    
    func getSurveyResult(_ hero: HeroIntroInfo) {
//        result = hero
    }
    
    func getDrawResult(_ hero: HeroIntroInfo){
        
    }
    
    func restart(){
        if (survey != nil){
            survey!.removeFromSuperview()
        }
        
        if (draw != nil){
            draw!.removeFromSuperview()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsTableViewCell
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        switch functionType {
//        case .whatsToday:
//            self.whatsToday()
//        case .heroRecommend:
//            self.heroRecommend()
//        case .lookingForGroup:
//            self.lookingForGroup()
//        default: break
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        print("will despe")
////        for v in view.subviews {
////            v.removeFromSuperview()
////        }
//    }
    
        
    
}


