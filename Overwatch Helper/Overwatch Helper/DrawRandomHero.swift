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
    var detailButton: UIButton
    var drawTimer: Timer?
    var Heros: [HeroIntroInfo] = []
    var heroIndex = 0
    
    weak var delegate: DrawHeroDelegate?
    
    override init(frame: CGRect) {
        heroImg = UIImageView(frame: CGRect(x: 37, y: 110, width: 300, height: 300))
        heroName = UILabel(frame: CGRect(x: 0, y: 200, width: 300, height: 100))
        stopButton = UIButton(frame: CGRect(x: 87, y: 430, width: 200, height: 50))
        detailButton = UIButton(frame:CGRect(x: 77, y: 500, width: 210, height: 50))
        

        
        
        Heros = heroArray
        super.init(frame: frame)
        
        self.addSubview(heroImg)
//        self.addSubview(heroName)
        
        heroImg.layer.cornerRadius = heroImg.frame.height/2
        heroImg.clipsToBounds = true
        heroImg.contentMode = .scaleAspectFill
        heroImg.addSubview(heroName)
        heroName.textAlignment = .center
        
        
        heroName.font = UIFont(name: "Verdana-BoldItalic", size: 35)
        heroName.textColor = UIColor.white
        heroName.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        
        stopButton.backgroundColor = UIColor(netHex: 0xFFC70C)
        stopButton.setTitleColor(UIColor.black, for: .normal)
        stopButton.transform = CGAffineTransform(a: 1, b: 0, c: -0.1, d: 1, tx: 0, ty: 0)
        stopButton.titleLabel?.font = UIFont(name: "Verdana-Bold", size: 30)
        
        stopButton.setTitle("Let's Rock!", for: .normal)
        stopButton.setTitleColor(UIColor.black, for: .normal)
        
        detailButton.backgroundColor = UIColor(netHex: 0xFFC70C)
        detailButton.setTitleColor(UIColor.black, for: .normal)
        detailButton.transform = CGAffineTransform(a: 1, b: 0, c: -0.1, d: 1, tx: 0, ty: 0)
        detailButton.titleLabel?.font = UIFont(name: "Verdana-Bold", size: 30)
        
        detailButton.setTitle("See Profile", for: .normal)
        detailButton.setTitleColor(UIColor.black, for: .normal)
        
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(stopButtonTapped(_:)))
        stopButton.addTarget(self, action: #selector(self.stopButtonTapped), for: .touchUpInside)

        self.addSubview(detailButton)
        self.addSubview(stopButton)
        print(stopButton.allTargets)
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
    
//    func stopButtonTapped(_ recognizer: UITapGestureRecognizer){
//        if (drawTimer == nil) {
//            start()
//        }else if (drawTimer?.isValid)!{
//            drawTimer?.invalidate()
//        }else{
//            start()
//        }
//    }
    
    func stopButtonTapped(){
        if (drawTimer == nil) {
            start()
            stopButton.setTitle("Stop", for: .normal)
            
        }else if (drawTimer?.isValid)!{
            drawTimer?.invalidate()
            stopButton.setTitle("Again?", for: .normal)
        }else{
            start()
            stopButton.setTitle("Stop", for: .normal)
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

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

protocol DrawHeroDelegate: class {
    func getDrawResult(_ hero : HeroIntroInfo)
}
