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
class PlayerHeader: UITableViewCell
{
    @IBOutlet weak var playerIcon: UIImageView!
    
    @IBOutlet weak var playerName: UILabel!
    
    @IBOutlet weak var gamesWon: UILabel!
    
    
    @IBOutlet weak var rankIcon: UIImageView!
    
    @IBOutlet weak var rankPoints: UILabel!
    
    @IBOutlet weak var featureImage: UIImageView!
    
}

class PlayerFeature: UITableViewCell
{
    @IBOutlet weak var featureNumber: UILabel!
    
    @IBOutlet weak var featureDescription: UILabel!
}

class PlayerTopHero: UITableViewCell
{
    var chart: Chart? // arc

    //@IBOutlet weak var view: UIView!
}

class PlayerStats: UITableViewCell
{
    //@IBOutlet weak var typeIcon: UIImageView!
    
    @IBOutlet weak var typeName: UILabel!
    
    @IBOutlet weak var typeDetail: UILabel!
    
}
