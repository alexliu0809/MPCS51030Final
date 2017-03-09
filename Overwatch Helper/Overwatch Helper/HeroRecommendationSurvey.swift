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
    
}

struct RecommendationQuestion {
    let options: [[String:Int]]
}
