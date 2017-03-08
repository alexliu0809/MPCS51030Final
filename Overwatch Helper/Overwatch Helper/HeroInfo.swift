//
//  HeroInfo.swift
//  Overwatch Helper
//
//  Created by Benyan Gong on 3/5/17.
//  Copyright © 2017 Alex&Ben. All rights reserved.
//

import Foundation
import UIKit

struct HeroInfo {
    
}
enum HeroType{
    case Tank
    case Offense
    case Support
    case Defense
}

class HeroDetailHeroIcon : UITableViewCell
{
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var iconLabel: UILabel!
    
}
class HeroDetailBasicInfo : UITableViewCell
{
    @IBOutlet weak var basicInfo: UILabel!
    
}
class HeroDetailDetailInfo : UITableViewCell
{
    @IBOutlet weak var detailInfo: UILabel!
    
}
class HeroIntroInfo
{
    var topImage : UIImage
    var difficulty : Int
    var heroType : HeroType
    var heroName : String
    init(name:String, image:UIImage, diff:Int, type:HeroType) {
        self.topImage = image
        self.heroName = name
        self.heroType = type
        self.difficulty = diff
    }
}
