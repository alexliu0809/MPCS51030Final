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
    
    var stopButton: UIButton//try again
    var detailButton: UIButton
    
    var heroImg: UIImageView
    var heroName: UILabel
    var backView: UIView
    var result: HeroIntroInfo?
    
    override init(frame: CGRect){
        question = UILabel(frame: (CGRect(x: 0, y: 350, width: 375, height:100)))
        option1 = UIButton(frame: CGRect(x: 575, y: 400, width: 250, height: 30))
        option2 = UIButton(frame: CGRect(x: 575, y: 450, width: 250, height: 30))
        option3 = UIButton(frame: CGRect(x: 575, y: 500, width: 250, height: 30))
        option4 = UIButton(frame: CGRect(x: 575, y: 550, width: 250, height: 30))
        stopButton = UIButton(frame: CGRect(x: 575, y: 435, width: 200, height: 50))
        detailButton = UIButton(frame:CGRect(x: 575, y: 505, width: 210, height: 50))
        
        
        
        heroImg = UIImageView(frame: CGRect(x: 92, y: 90, width: 190, height: 190))
        heroName = UILabel(frame: CGRect(x: 0, y: 130, width: 190, height: 60))
        
        
        heroImg.layer.cornerRadius = heroImg.frame.height/2
        heroImg.clipsToBounds = true
//        heroImg.contentMode = .scaleToFill
        heroImg.addSubview(heroName)
        heroImg.backgroundColor = UIColor(netHex: 0x484848)
        heroImg.image = #imageLiteral(resourceName: "questionMark")
        
        backView = UIView(frame: CGRect(x: 72, y: 70, width: 230, height: 230))
        backView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        backView.layer.cornerRadius = 115
        backView.clipsToBounds = true
        
        heroName.textAlignment = .center
        
        
        heroName.font = UIFont(name: "Verdana-BoldItalic", size: 27)
        heroName.textColor = UIColor.white
        heroName.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        
        
        
        super.init(frame: frame)
        
        
        
        question.backgroundColor = UIColor(hexString: "F89E19")
        question.font = UIFont(name: "Verdana-BoldItalic", size: 27)
        question.numberOfLines = 0
        question.frame.size.width = 375
        question.lineBreakMode = .byWordWrapping
        question.sizeToFit()
        question.layer.masksToBounds = true
        question.layer.cornerRadius = 5
        question.transform = CGAffineTransform(a: 1, b: 0, c: -0.1, d: 1, tx: 0, ty: 0)
        question.textAlignment = .left

//        
        
        initOption(option1)
        initOption(option2)
        initOption(option3)
        initOption(option4)
        
        
        
        
        
        
        option1.addTarget(self, action: #selector(self.choose1), for: .touchUpInside)
        option2.addTarget(self, action: #selector(self.choose2), for: .touchUpInside)
        option3.addTarget(self, action: #selector(self.choose3), for: .touchUpInside)
        option4.addTarget(self, action: #selector(self.choose4), for: .touchUpInside)
        
        
        
        
        stopButton.backgroundColor = UIColor(hexString: "F89E19")
        stopButton.transform = CGAffineTransform(a: 1, b: 0, c: -0.1, d: 1, tx: 0, ty: 0)
        stopButton.titleLabel?.font = UIFont(name: "Verdana-Bold", size: 30)
        stopButton.layer.cornerRadius = 5
        
        stopButton.setTitle("Try again", for: .normal)
        stopButton.setTitleColor(UIColor.white, for: .normal)
        stopButton.isEnabled = true
        
        detailButton.backgroundColor = UIColor(hexString: "F89E19")
        detailButton.setTitleColor(UIColor.white, for: .normal)
        detailButton.transform = CGAffineTransform(a: 1, b: 0, c: -0.1, d: 1, tx: 0, ty: 0)
        detailButton.titleLabel?.font = UIFont(name: "Verdana-Bold", size: 30)
        detailButton.isEnabled = true
        
        
        detailButton.setTitle("See Profile", for: .normal)
        detailButton.setTitleColor(UIColor.white, for: .normal)
        detailButton.layer.cornerRadius = 5

        
        self.addSubview(question)
        self.addSubview(option1)
        self.addSubview(option2)
        self.addSubview(option3)
        self.addSubview(option4)
        self.addSubview(backView)
        heroImg.addSubview(heroName)
        self.addSubview(heroImg)
        
        
        stopButton.addTarget(self, action: #selector(self.stopButtonTapped), for: .touchUpInside)
        detailButton.addTarget(self, action: #selector(self.selectionHandler), for: .touchUpInside)
        
        
        self.addSubview(detailButton)
        self.addSubview(stopButton)
    }
    
    func initOption(_ option1: UIButton){
        option1.backgroundColor = UIColor(hexString: "F89E19")
        option1.titleLabel?.font = UIFont(name: "Verdana-BoldItalic", size: 20)
        option1.layer.cornerRadius = 5
        option1.transform = CGAffineTransform(a: 1, b: 0, c: -0.1, d: 1, tx: 0, ty: 0)
        option1.titleLabel?.textAlignment = .left
        option1.contentHorizontalAlignment = .left
        option1.setTitleColor(UIColor.black, for: .normal)
        option1.alpha = 0
    }
    
    func surveyStart(){
        nextQuestion()
    }
    
    func restart(){
        nextQuestionIndex = -1
        initOption(option1)
        initOption(option2)
        initOption(option3)
        initOption(option4)
        HeroLeft = heroArray
        option1.isEnabled = true
        option2.isEnabled = true
        option3.isEnabled = true
        option4.isEnabled = true
        stopButton.center.x = 575
        detailButton.center.x = 575
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
        UIView.animate(withDuration: 0.1, animations: {
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
                self.question.frame.size.width = 375
                self.question.sizeToFit()
//                self.question.center.x = 187.5
                
                self.option1.setTitle("   " + self.Questions[self.nextQuestionIndex].options[0], for: .normal)
                self.option2.setTitle("   " + self.Questions[self.nextQuestionIndex].options[1], for: .normal)
                self.option3.setTitle("   " + self.Questions[self.nextQuestionIndex].options[2], for: .normal)
                self.option4.setTitle("   " + self.Questions[self.nextQuestionIndex].options[3], for: .normal)
                if self.option1.title(for: .normal) != "   "{
                    self.option1.center.x = 187
                    self.option1.alpha = 1
                }
                if self.option2.title(for: .normal) != "   "{
                    self.option2.center.x = 187
                    self.option2.alpha = 1
                }
                if self.option3.title(for: .normal) != "   "{
                    self.option3.center.x = 187
                    self.option3.alpha = 1
                }
                if self.option4.title(for: .normal) != "   "{
                    self.option4.center.x = 187
                    self.option4.alpha = 1
                }
                
                
                
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
            delegate?.heroNotFound()
            return
        }
        HeroLeft.shuffle()
        result = HeroLeft[0]
        heroImg.image = HeroLeft[0].topImage
        heroName.text = HeroLeft[0].heroName
        question.frame.size.width = 375
        question.sizeToFit()
        question.text = "Your best choice is: \(HeroLeft[0].heroName)"
        
        
        UIView.animate(withDuration: 0.5, animations: {
            self.detailButton.center.x = 187.5
            self.stopButton.center.x = 187.5
        })
        
        
    }
    
    func selectionHandler(){
        delegate?.getSurveyResult(result!)
    }
    
    func stopButtonTapped(){
        restart()
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol SurveyDelegate: class {
 
    func getSurveyResult(_ hero: HeroIntroInfo)
    func heroNotFound()
}


