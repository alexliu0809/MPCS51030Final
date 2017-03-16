//
//  RandomHero.swift
//  Overwatch Helper
//
//  Created by Benyan Gong on 3/10/17.
//  Copyright © 2017 Alex&Ben. All rights reserved.
//

import UIKit

//Whats today page
class DrawRandomHero: UIView {
    
    /// hero Portrait
    var heroImg: UIImageView
    
    /// hero name tag
    var heroName: UILabel
    
    /// stop
    var stopButton: UIButton
    
    /// show detail
    var detailButton: UIButton
    
    /// background image
    var backView: UIView
    
    /// timer for drawing hero
    var drawTimer: Timer?
    
    /// all hero list
    var Heros: [HeroIntroInfo] = []
    
    /// current showing hero index
    var heroIndex = 0
    
    weak var delegate: DrawHeroDelegate?
    
    override init(frame: CGRect) {
        
        //-------------------------view intialization--------------------------------
        heroImg = UIImageView(frame: CGRect(x: 82, y: 130, width: 210, height: 210))
        heroName = UILabel(frame: CGRect(x: 0, y: 150, width: 210, height: 60))
        stopButton = UIButton(frame: CGRect(x: 87, y: 435, width: 200, height: 50))
        detailButton = UIButton(frame:CGRect(x: 77, y: 505, width: 210, height: 50))
        backView = UIView(frame: CGRect(x: 62, y: 110, width: 250, height: 250))
        backView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        backView.layer.cornerRadius = 125
        backView.clipsToBounds = true
        
        Heros = heroArray
        
        super.init(frame: frame)
        
        self.addSubview(backView)
        self.addSubview(heroImg)
        
        heroImg.layer.cornerRadius = heroImg.frame.height/2
        heroImg.clipsToBounds = true
        heroImg.contentMode = .scaleAspectFill
        heroImg.addSubview(heroName)
        heroImg.backgroundColor = UIColor(netHex: 0x363636)
        
        heroName.textAlignment = .center
        
        
        heroName.font = UIFont(name: "Verdana-BoldItalic", size: 27)
        heroName.textColor = UIColor.white
        heroName.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        
        stopButton.backgroundColor = UIColor(hexString: "F89E19")
        stopButton.transform = CGAffineTransform(a: 1, b: 0, c: -0.1, d: 1, tx: 0, ty: 0)
        stopButton.titleLabel?.font = UIFont(name: "Verdana-Bold", size: 30)
        stopButton.layer.cornerRadius = 5
        
        stopButton.setTitle("Let's Rock!", for: .normal)
        stopButton.setTitleColor(UIColor.black, for: .normal)
        
        detailButton.backgroundColor = UIColor(hexString: "F89E19")
        detailButton.setTitleColor(UIColor.black, for: .normal)
        detailButton.transform = CGAffineTransform(a: 1, b: 0, c: -0.1, d: 1, tx: 0, ty: 0)
        detailButton.titleLabel?.font = UIFont(name: "Verdana-Bold", size: 30)
        detailButton.isEnabled = false
        detailButton.alpha = 0
        
        detailButton.setTitle("See Profile", for: .normal)
        detailButton.setTitleColor(UIColor.black, for: .normal)
        detailButton.layer.cornerRadius = 5
        
        stopButton.addTarget(self, action: #selector(self.stopButtonTapped), for: .touchUpInside)
        detailButton.addTarget(self, action: #selector(self.selectionHandler), for: .touchUpInside)

        
        self.addSubview(detailButton)
        self.addSubview(stopButton)
        
        NSLog("Stop Button Targets:\(stopButton.allTargets)")
        //---------------------------------------------------
    }
    
    
    /// start drawing
    func start(){
        guard Heros.count > 0 else {
            return
        }
        drawTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(changeHero), userInfo: nil, repeats: true)
    }
    
    
    /// change hero
    func changeHero(){
        heroIndex += 1
        if heroIndex >= Heros.count{
            heroIndex = 0
        }
        NSLog("Hero Index:\(heroIndex)")
        
        self.heroImg.image = self.Heros[self.heroIndex].topImage
        self.heroName.text = self.Heros[self.heroIndex].heroName

        
    }
    
    
    /// stop button handler
    func stopButtonTapped(){
        if (drawTimer == nil) {
            start()
            stopButton.setTitle("Stop", for: .normal)
            
        }else if (drawTimer?.isValid)!{
            drawTimer?.invalidate()
            setBtn(false)
        }else{
            setBtn(true)
            start()
        }
    }
    
    
    /// stop drawing
    func stop(){
        if (drawTimer == nil) {
            return
        }else if (drawTimer?.isValid)!{
            drawTimer?.invalidate()
            setBtn(false)
        }
    }
    
    
    /// set stopButton title
    func setBtn(_ toStop: Bool){
        if toStop{
            stopButton.setTitle("Stop", for: .normal)
            detailButton.isEnabled = false
            detailButton.alpha = 0
        } else {
            stopButton.setTitle("Again?", for: .normal)
            detailButton.isEnabled = true
            detailButton.alpha = 1
        }
    }
    
    
    /// hero selected, get result
    func selectionHandler(){
        NSLog("Selected Hero Name: \(Heros[heroIndex].heroName)")
        delegate?.getDrawResult(Heros[heroIndex])
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


/// delegate for discover controller trigger segue
protocol DrawHeroDelegate: class {
    func getDrawResult(_ hero : HeroIntroInfo)
}
