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
        question = UILabel(frame: (CGRect(x: 0, y: 350, width: 375, height:100)))
        option1 = UIButton(frame: CGRect(x: 87, y: 400, width: 200, height: 30))
        option2 = UIButton(frame: CGRect(x: 87, y: 450, width: 200, height: 30))
        option3 = UIButton(frame: CGRect(x: 87, y: 500, width: 200, height: 30))
        option4 = UIButton(frame: CGRect(x: 87, y: 550, width: 200, height: 30))
        
        super.init(frame: frame)
        
        
        
        question.backgroundColor = UIColor(hexString: "F89E19")
        question.font = UIFont(name: "Verdana-BoldItalic", size: 27)
        question.numberOfLines = 0
        question.lineBreakMode = .byWordWrapping
        question.sizeToFit()
        
        
        initOption(option1)
        initOption(option2)
        initOption(option3)
        initOption(option4)
        
        
        
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
    
    func initOption(_ option1: UIButton){
        option1.titleLabel?.text = "Option1"
        option1.setTitle("Option1", for: .normal)
        option1.backgroundColor = UIColor(hexString: "F89E19")
        option1.titleLabel?.font = UIFont(name: "Verdana-BoldItalic", size: 20)
        option1.layer.cornerRadius = 5
        option1.transform = CGAffineTransform(a: 1, b: 0, c: -0.1, d: 1, tx: 0, ty: 0)
        option1.titleLabel?.textAlignment = .left
        option1.contentHorizontalAlignment = .left
        option1.setTitleColor(UIColor.black, for: .normal)
    }
    
    func surveyStart(){
        nextQuestion()
    }
    
    func cursurOn(button: UIButton) {
        
        button.backgroundColor = UIColor.black
    }
    
    func choose1(){
        UIView.animate(withDuration: 0.1, animations: {
            self.option1.alpha = 0
        }, completion: {finish in
            
        })
        self.makeChoice(0)
    }
    func choose2(){
        UIView.animate(withDuration: 0.1, animations: {
            self.option2.alpha = 0
        }, completion: {finish in
            self.makeChoice(1)
        })
    }
    func choose3(){
        UIView.animate(withDuration: 0.1, animations: {
            self.option3.alpha = 0
        }, completion: {finish in
            self.makeChoice(2)
        })
    }
    func choose4(){
        UIView.animate(withDuration: 0.5, animations: {
            self.option4.alpha = 0
        }, completion: {finish in
            self.makeChoice(3)
        })
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
                self.question.sizeToFit()
                
                self.option1.setTitle("   " + self.Questions[self.nextQuestionIndex].options[0], for: .normal)
                self.option2.setTitle("   " + self.Questions[self.nextQuestionIndex].options[1], for: .normal)
                self.option3.setTitle("   " + self.Questions[self.nextQuestionIndex].options[2], for: .normal)
                self.option4.setTitle("   " + self.Questions[self.nextQuestionIndex].options[3], for: .normal)
                self.option1.center.x = 187
                self.option2.center.x = 187
                self.option3.center.x = 187
                self.option4.center.x = 187
                self.option1.alpha = 1
                self.option2.alpha = 1
                self.option3.alpha = 1
                self.option4.alpha = 1
            })
        }
    }
    
    func makeChoice(_ choice : Int){
        guard !HeroLeft.isEmpty else {
            return
        }
        
        HeroLeft = Questions[nextQuestionIndex].getResult(HeroLeft,choice)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.option2.center.x = -200
            self.option1.center.x = -200
            self.option3.center.x = -200
            self.option4.center.x = -200
        }, completion: {finish in
            self.nextQuestion()
            self.option1.center.x = 575
            self.option2.center.x = 575
            self.option3.center.x = 575
            self.option4.center.x = 575
        })
//        nextQuestion()
        
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


