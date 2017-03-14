//
//  PlayerStatsCellProto.swift
//  Overwatch Helper
//
//  Created by Enze on 3/9/17.
//  Copyright © 2017 Alex&Ben. All rights reserved.
//

import Foundation
import UIKit
import SwiftCharts


/// Player Info First Cell
class PlayerHeader: UITableViewCell
{
    @IBOutlet weak var playerIcon: UIImageView! //icon iamge
    
    @IBOutlet weak var playerName: UILabel! //name
    
    @IBOutlet weak var gamesWon: UILabel! //games won
    
    
    @IBOutlet weak var rankIcon: UIImageView! //rank icon image
    
    @IBOutlet weak var rankPoints: UILabel! //rank point
    
    @IBOutlet weak var featureImage: UIImageView! //feature image
    
}
/// Player Feature Cell
class PlayerFeature: UITableViewCell
{
    //Feature Val
    @IBOutlet weak var featureNumber: UILabel!
    
    //Feature Image
    @IBOutlet weak var featureImg: UIImageView!
    
    //Feature Description
    @IBOutlet weak var featureDescription: UILabel!
}


/// Displaying Top Hero Chart
class PlayerTopHero: UITableViewCell
{
    var chart: Chart? // The Chart
}


/// Displaying Other player stats
class PlayerStats: UITableViewCell
{
    
    @IBOutlet weak var typeName: UILabel! //player stats type name
    
    @IBOutlet weak var typeDetail: UILabel! //player stats type val
    
}
