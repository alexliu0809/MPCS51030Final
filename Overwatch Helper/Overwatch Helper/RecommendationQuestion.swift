//
//  RecommendationQuestion.swift
//  Overwatch Helper
//
//  Created by Benyan Gong on 3/11/17.
//  Copyright © 2017 Alex&Ben. All rights reserved.
//

import Foundation

//recommendation questions
class RQ {
    
    /// question option
    var options: [String] = []
    
    /// question body
    let question: String
    
    /// static question lists, hardcoded so far
    static let questions: [RQ] = [RQ_Dfct("Experienced FPS Player?",["Brand New", "Little Experience","Hardcore",""]), RQ_Type("Which role you want to play?",["Defence", "Offense","Support","Tank"])]
    
    init(_ question: String, _ options: [String]){
        
        self.question = question
        for i in options {
            self.options.append(i)

        }
    }
    
    /// get question result prototype
    ///
    /// - Parameters:
    ///   - list
    ///   - choice
    /// - Returns: List of heros left
    func getResult(_ list : [HeroIntroInfo], _ choice : Int) -> ([HeroIntroInfo]){
        return []
    }
}


/// Difficulty question
class RQ_Dfct: RQ{
    

    override func getResult(_ list : [HeroIntroInfo], _ choice: Int) -> ([HeroIntroInfo]) {
        var result: [HeroIntroInfo] = []
        let diff = choice+1
        for i in list{
            if i.difficulty == diff {
                result.append(i)
            }
        }
        return result
    }
}


/// Type preference question
class RQ_Type: RQ {
    
    override func getResult(_ list : [HeroIntroInfo], _ choice: Int) -> ([HeroIntroInfo]) {
        var result: [HeroIntroInfo] = []
        var diff: HeroType
        switch choice {
        case 0:
            diff = .Defense
        case 1:
            diff = .Offense
        case 2:
            diff = .Support
        case 3:
            diff = .Tank
        default:
            diff = .NotDefined
        }
        for i in list{
            if i.heroType == diff {
                result.append(i)
            }
        }
        return result
    }
}
