//
//  PlayerStats.swift
//  Overwatch Helper
//
//  Created by Enze on 3/9/17.
//  Copyright © 2017 Alex&Ben. All rights reserved.
//

import Foundation
class PlayerStatatistic {
    var playerLevel : Int?
    var iconImageURL : String?
    var playerName : String?
    var gamesWon : String?
    var rankIconURL : String?
    var rankPoints : String?
    //var featureImageURL = "https://blzgdapipro-a.akamaihd.net/hero/mercy/career-portrait.png"
    var featureNumbers:[String] = []
    var featureDescription:[String] = []
    

    var typeDetails:[typeDetail] = []
    
    var topHeros:[topInfo] = []
    
    init() {
        
    }
}

class topInfo{
    var topHerosName:String
    var topHeroTime:Double
    init(name:String,time:Double) {
        self.topHeroTime = time
        self.topHerosName = name
    }
}

class typeDetail
{
    //var typeIconURL:String?
    var typeName:String?
    var subTitle:[String] = []
    var subVal:[String] = []
    init() {
        
    }
}
