//
//  HeroInfo.swift
//  Overwatch Helper
//
//  Created by Benyan Gong on 3/5/17.
//  Copyright © 2017 Alex&Ben. All rights reserved.
//

import Foundation
import UIKit

struct MapInfo {
    
}
enum MapType{
    case Assault
    case Escort
    case Hybrid
    case Control
    case Arena
}

class MapDetailMapIcon : UITableViewCell
{
    @IBOutlet weak var mapImage: UIImageView!
    
}
class MapDetailBasicInfo : UITableViewCell
{
    @IBOutlet weak var location: UILabel!

    @IBOutlet weak var terrain: UILabel!
    
    @IBOutlet weak var type: UILabel!
}
class MapDetailDetailInfo : UITableViewCell
{

    @IBOutlet weak var mapBrief: UITextView!
    
}
class MapIntroInfo
{
    var topImage : UIImage
    var mapType : String
    var location : String
    var terrain: String
    var flagImage: UIImage
    init(loacation: String, mapImage: UIImage, flagImage: UIImage, type: String, terrain: String) {
        self.topImage = mapImage
        self.location = loacation
        self.mapType = type
        self.flagImage = flagImage
        self.terrain = terrain
    }
}
