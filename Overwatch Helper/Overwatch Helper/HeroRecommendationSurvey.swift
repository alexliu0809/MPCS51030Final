//
//  HeroRecommendationSurvey.swift
//  Overwatch Helper
//
//  Created by Benyan Gong on 3/9/17.
//  Copyright © 2017 Alex&Ben. All rights reserved.
//

import Foundation
import UIKit

class HeroRecommendationSurvey: UIView {
    var HeroScores: [Int] = []
    var Questions: [RecommendationQuestion] = []
    var nextQuestionIndex = 0
    
    let question = UILabel(frame: (CGRect(x: 20, y: 100, width: 200, height: 50)))
    let option1 = UIButton(frame: CGRect(x: 20, y: 160, width: 200, height: 50))
    let option2 = UIButton(frame: CGRect(x: 20, y: 220, width: 200, height: 50))
    let option3 = UIButton(frame: CGRect(x: 20, y: 280, width: 200, height: 50))
    let option4 = UIButton(frame: CGRect(x: 20, y: 340, width: 200, height: 50))
    
    init(){
        super.init(frame: CGRect(x: 0, y: 0, width: 375, height: 500))
        
        question.text = "question1"
        question.backgroundColor = UIColor.brown
        
        option1.titleLabel?.text = "Option1"
        option1.setTitle("Option1", for: .normal)
        option1.backgroundColor = UIColor.brown
        
        option2.titleLabel?.text = "Option2"
        option2.setTitle("Option2", for: .normal)
        
        option3.titleLabel?.text = "Option3"
        option3.setTitle("Option3", for: .normal)
        
        option4.titleLabel?.text = "Option4"
        option4.setTitle("Option4", for: .normal)

        option1.addTarget(self, action: #selector(self.choose1), for: .touchUpInside)
        option2.addTarget(self, action: #selector(self.choose2), for: .touchUpInside)
        option3.addTarget(self, action: #selector(self.choose3), for: .touchUpInside)
        option4.addTarget(self, action: #selector(self.choose4), for: .touchUpInside)
        
        self.addSubview(question)
        self.addSubview(option1)
        self.addSubview(option2)
        self.addSubview(option3)
        self.addSubview(option4)
        
        nextQuestion()
    }
    
    func choose1(){
        makeChoice(0)
    }
    func choose2(){
        makeChoice(1)
    }
    func choose3(){
        makeChoice(2)
    }
    func choose4(){
        makeChoice(3)
    }
    
    func nextQuestion() {
        if nextQuestionIndex == Questions.count{
            settle()
            return
        }
        DispatchQueue.main.async {
            UIView.animate(withDuration: <#T##TimeInterval#>, animations: {
                self.question.text = self.Questions[self.nextQuestionIndex].question
                self.option1.setTitle(self.Questions[self.nextQuestionIndex].options[0], for: .normal)
                self.option2.setTitle(self.Questions[self.nextQuestionIndex].options[1], for: .normal)
                self.option3.setTitle(self.Questions[self.nextQuestionIndex].options[2], for: .normal)
                self.option4.setTitle(self.Questions[self.nextQuestionIndex].options[3], for: .normal)
            })
        }
    }
    
    func makeChoice(_ choice : Int){
        for i in 0...HeroScores.count{
            HeroScores[i] += (Questions[nextQuestionIndex].choice[choice]?[i])!
        }
        nextQuestionIndex += 1
        nextQuestion()
    }
    
    func settle(){
//        maxHero
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

struct RecommendationQuestion {
    let choice: [Int:[Int]]
    let options: [String] = ["option1"]
    let question: String = "question1"
}
