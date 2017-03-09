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
//    @IBOutlet weak var iconImage: UIImageView!
//    @IBOutlet weak var iconLabel: UILabel!
    
}
class MapDetailBasicInfo : UITableViewCell
{
//    @IBOutlet weak var basicInfo: UILabel!
    
}
class MapDetailDetailInfo : UITableViewCell
{
//    @IBOutlet weak var detailInfo: UILabel!
    @IBOutlet weak var mapBrief: UITextView!
    
}
class MapIntroInfo
{
    var topImage : UIImage
    var mapType : MapType
    var location : String
    var flagImage: UIImage
    init(loacation: String, mapImage: UIImage, flagImage: UIImage, type: MapType) {
        self.topImage = mapImage
        self.location = loacation
        self.mapType = type
        self.flagImage = flagImage
    }
}
