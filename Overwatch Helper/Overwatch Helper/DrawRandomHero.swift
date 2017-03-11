//
//  RandomHero.swift
//  Overwatch Helper
//
//  Created by Benyan Gong on 3/10/17.
//  Copyright © 2017 Alex&Ben. All rights reserved.
//

import UIKit

class DrawRandomHero: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var heroImg: UIImageView
    var heroName: UILabel
    var stopButton: UIButton
    var drawTimer: Timer?
    var Heros: [HeroIntroInfo] = []
    var heroIndex = 0
    
    weak var delegate: DrawHeroDelegate?
    
    override init(frame: CGRect) {
        heroImg = UIImageView(frame: CGRect(x: 37, y: 200, width: 300, height: 200))
        heroName = UILabel(frame: CGRect(x: 37, y: 420, width: 300, height: 100))
        stopButton = UIButton(frame: CGRect(x: 37, y: 520, width: 300, height: 50))
        

        
        
        Heros = heroArray
        super.init(frame: frame)
        
        self.addSubview(heroImg)
        self.addSubview(heroName)
        
        self.isUserInteractionEnabled = true
        
        heroName.backgroundColor = UIColor.white
        stopButton.backgroundColor = UIColor.white
        stopButton.setTitle("Stop", for: .normal)
        stopButton.setTitleColor(UIColor.black, for: .normal)
//        stopButton.isUserInteractionEnabled
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(stopButtonTapped(_:)))
//        stopButton.addTarget(self, action: #selector(self.stopButtonTapped), for: .touchUpInside))
        stopButton.addGestureRecognizer(tap)
        self.addSubview(stopButton)
    }
    
    func start(){
        guard Heros.count > 0 else {
            return
        }
        drawTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(changeHero), userInfo: nil, repeats: true)
    }
    
    func changeHero(){
        if heroIndex >= Heros.count{
            heroIndex = 0
        }
        print(heroIndex)
        heroImg.image = Heros[heroIndex].topImage
        heroName.text = Heros[heroIndex].heroName
        heroIndex += 1
    }
    
    func stopButtonTapped(_ recognizer: UITapGestureRecognizer){
        if (drawTimer == nil) {
            start()
        }else if (drawTimer?.isValid)!{
            drawTimer?.invalidate()
        }else{
            start()
        }
    }
    
    func stop(){
        if (drawTimer == nil) {
            return
        }else if (drawTimer?.isValid)!{
            drawTimer?.invalidate()
        }
    }
    
    func selectionHandler(){
        delegate?.getDrawResult(Heros[heroIndex])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

protocol DrawHeroDelegate: class {
    func getDrawResult(_ hero : HeroIntroInfo)
}
