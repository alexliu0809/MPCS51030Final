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
    weak var delegate: SurveyDelegate?
    
    var HeroLeft: [HeroIntroInfo] = heroArray
    var Questions: [RQ] = RQ.questions
    var nextQuestionIndex = -1
    
    var question: UILabel
    var option1: UIButton
    var option2: UIButton
    var option3: UIButton
    var option4: UIButton
//    var result: HeroIntroInfo?
    
    override init(frame: CGRect){
        question = UILabel(frame: (CGRect(x: 0, y: 100, width: 375, height: 50)))
        option1 = UIButton(frame: CGRect(x: 87, y: 160, width: 200, height: 50))
        option2 = UIButton(frame: CGRect(x: 87, y: 220, width: 200, height: 50))
        option3 = UIButton(frame: CGRect(x: 87, y: 280, width: 200, height: 50))
        option4 = UIButton(frame: CGRect(x: 87, y: 340, width: 200, height: 50))
        
        super.init(frame: frame)
        
        
        
        question.text = "question1"
        question.backgroundColor = UIColor(netHex: 0xFFC70C)
        
        option1.titleLabel?.text = "Option1"
        option1.setTitle("Option1", for: .normal)
        option1.backgroundColor = UIColor(netHex: 0xFFC70C)
        
        option2.titleLabel?.text = "Option2"
        option2.setTitle("Option2", for: .normal)
        option2.backgroundColor = UIColor(netHex: 0xFFC70C)
        
        option3.titleLabel?.text = "Option3"
        option3.setTitle("Option3", for: .normal)
        option3.backgroundColor = UIColor(netHex: 0xFFC70C)
        
        option4.titleLabel?.text = "Option4"
        option4.setTitle("Option4", for: .normal)
        option4.backgroundColor = UIColor(netHex: 0xFFC70C)
        
        option1.addTarget(self, action: #selector(self.choose1), for: .touchUpInside)
        option2.addTarget(self, action: #selector(self.choose2), for: .touchUpInside)
        option3.addTarget(self, action: #selector(self.choose3), for: .touchUpInside)
        option4.addTarget(self, action: #selector(self.choose4), for: .touchUpInside)
        self.addSubview(question)
        self.addSubview(option1)
        self.addSubview(option2)
        self.addSubview(option3)
        self.addSubview(option4)
    }
    
    func surveyStart(){
        nextQuestion()
    }
    
    func cursurOn(button: UIButton) {
        
        button.backgroundColor = UIColor.black
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
        nextQuestionIndex += 1
        if nextQuestionIndex >= Questions.count{
            settle()
            return
        }
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3, animations: {
                self.question.text = self.Questions[self.nextQuestionIndex].question
                self.option1.setTitle(self.Questions[self.nextQuestionIndex].options[0], for: .normal)
                self.option2.setTitle(self.Questions[self.nextQuestionIndex].options[1], for: .normal)
                self.option3.setTitle(self.Questions[self.nextQuestionIndex].options[2], for: .normal)
                self.option4.setTitle(self.Questions[self.nextQuestionIndex].options[3], for: .normal)
            })
        }
    }
    
    func makeChoice(_ choice : Int){
        guard !HeroLeft.isEmpty else {
            return
        }

        HeroLeft = Questions[nextQuestionIndex].getResult(HeroLeft,choice)
        nextQuestion()
    }
    
    func settle(){
        option1.isEnabled = false
        option2.isEnabled = false
        option3.isEnabled = false
        option4.isEnabled = false
        guard HeroLeft.count > 0 else {
//            delegate?.getSurveyResult(HeroIntroInfo())
            return
        }
        HeroLeft.shuffle()
        let result = HeroLeft[0]
        delegate?.getSurveyResult(result)
        
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol SurveyDelegate: class {
 
    func getSurveyResult(_ hero: HeroIntroInfo)
    
}


