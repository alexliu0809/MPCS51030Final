//
//  HeroRecommendationSurvey.swift
//  Overwatch Helper
//
//  Created by Benyan Gong on 3/9/17.
//  Copyright © 2017 Alex&Ben. All rights reserved.
//

import Foundation

class HeroRecommendationSurvey {
    var HeroScores: [Int] = []
    var Questions: [RecommendationQuestion] = []
    
    @objc func choose1(){
        print("choose1")
    }
    func choose2(){
        
    }
    func choose3(){
        
    }
    func choose4(){
        
    }
    
}

struct RecommendationQuestion {
    let options: [[String:Int]]
}
