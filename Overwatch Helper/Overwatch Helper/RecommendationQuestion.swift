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
    
    /// <#Description#>
    var options: [String] = []
    
    /// <#Description#>
    let question: String
    
    /// <#Description#>
    static let questions: [RQ] = [RQ_Dfct("Experienced FPS Player?",["Brand New", "Little Experience","Hardcore",""]), RQ_Type("Which role you want to play?",["Defence", "Offense","Support","Tank"])]
    
    init(_ question: String, _ options: [String]){
        
        self.question = question
        for i in options {
            self.options.append(i)

        }
    }
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - list: <#list description#>
    ///   - choice: <#choice description#>
    /// - Returns: <#return value description#>
    func getResult(_ list : [HeroIntroInfo], _ choice : Int) -> ([HeroIntroInfo]){
        return []
    }
}


/// <#Description#>
class RQ_Dfct: RQ{
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - list: <#list description#>
    ///   - choice: <#choice description#>
    /// - Returns: <#return value description#>
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


/// <#Description#>
class RQ_Type: RQ {
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - list: <#list description#>
    ///   - choice: <#choice description#>
    /// - Returns: <#return value description#>
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
