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
    var drawTimer: Timer?
    var Heros: [HeroIntroInfo] = []
    var heroIndex = 0
    
    weak var delegate: DrawHeroDelegate?
    
    override init(frame: CGRect) {
        heroImg = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        heroName = UILabel(frame: CGRect(x: 0, y: 320, width: 300, height: 100))
        super.init(frame: frame)
    }
    
    func start(){
        guard Heros.count > 0 else {
            return
        }
        drawTimer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(changeHero), userInfo: nil, repeats: true)
    }
    
    func changeHero(){
        if heroIndex > Heros.count{
            heroIndex = 0
        }
        heroImg.image = Heros[heroIndex].topImage
        heroIndex += 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

protocol DrawHeroDelegate: class {
    func getDrawResult(_ hero : HeroIntroInfo)
}
