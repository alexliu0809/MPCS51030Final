//
//  HeroInfo.swift
//  Overwatch Helper
//
//  Created by Benyan Gong on 3/5/17.
//  Copyright © 2017 Alex&Ben. All rights reserved.
//

import Foundation
import UIKit
import YouTubePlayer_Swift

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
    @IBOutlet weak var youtubePlayer: YouTubePlayerView!
    
    
}
 
class HeroDetailDetailInfo : UITableViewCell
{
    @IBOutlet weak var detailInfoTitle: UILabel!
    @IBOutlet weak var detailInfo: UILabel!
    @IBOutlet weak var detailInfoImage: UIImageView!
    
}
class HeroIntroInfo
{
    var topImage : UIImage
    var difficulty : Int
    var heroType : HeroType
    var heroName : String
    var heroID : Int
    var heroAbilityName:[String] = []
    var heroAbilityDescription:[String] = []
    var heroAbilityImage:[UIImage] = []
    var videoUrl:String
    
    init(name:String, image:UIImage, diff:Int, type:HeroType, id:Int, url:String) {
        self.topImage = image
        self.heroName = name
        self.heroType = type
        self.difficulty = diff
        self.heroID = id
        self.videoUrl = url
    }
    
    func setHeroAblity(des:String,name:String,img:UIImage)
    {
        self.heroAbilityName.append(name)
        self.heroAbilityDescription.append(des)
        self.heroAbilityImage.append(img)
    }
}
