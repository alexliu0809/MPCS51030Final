//
//  PlayerStats.swift
//  Overwatch Helper
//
//  Created by Enze on 3/9/17.
//  Copyright © 2017 Alex&Ben. All rights reserved.
//

import Foundation

/// Saving Player Stats
class PlayerStatatistic {
    
    /// Player Level
    var playerLevel : Int?
    
    /// Player icon
    var iconImageURL : String?
    
    /// Player Name
    var playerName : String?
    
    /// Games Won
    var gamesWon : String?
    
    /// Player Rank Icon
    var rankIconURL : String?
    
    /// Player Rank point
    var rankPoints : String?
    //var featureImageURL = "https://blzgdapipro-a.akamaihd.net/hero/mercy/career-portrait.png"
    
    
    /// Player Feature Data Vals
    var featureNumbers:[String] = []
    
    
    /// Player Feature Data Description
    var featureDescription:[String] = []
    
    
    /// Player Other Infomartion Array
    var typeDetails:[typeDetail] = []
    
    
    /// Player top hero info array
    var topHeros:[topInfo] = []
    
    init() {
        
    }
}


/// The top heros that the player plays
class topInfo{
    var topHerosName:String //HERO NAME
    var topHeroTime:Double //hero time
    
    /// Init a top hero info
    ///
    /// - Parameters:
    ///   - name: hero name
    ///   - time: hero time
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
