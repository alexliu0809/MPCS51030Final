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


/// No used
struct HeroInfo {

}

/// Hero Type
///
/// - Tank: Tank
/// - Offense: Offense
/// - Support: Support
/// - Defense: Defense
/// - NotDefined: Not defined (default)
enum HeroType{
    case Tank
    case Offense
    case Support
    case Defense
    case NotDefined
}


/// Hero Detail Cell for hero icon image
class HeroDetailHeroIcon : UITableViewCell
{
    @IBOutlet weak var iconImage: UIImageView! //the image
    //@IBOutlet weak var iconLabel: UILabel!
    
}


/// For hero basic info
class HeroDetailBasicInfo : UITableViewCell, YouTubePlayerDelegate
{
    //display the video
    @IBOutlet weak var youtubePlayer: YouTubePlayerView!
    
    //loading image with indciator
    var loadingView: UIActivityIndicatorView?
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //        self.video.delegate = self
        
        //configure indicator
        loadingView = UIActivityIndicatorView(frame: CGRect(x: 25 , y: 25, width: 50, height: 50))
        
        loadingView?.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        loadingView?.tintColor = UIColor(hexString: "F89E19")
        loadingView?.backgroundColor = UIColor.clear
        loadingView?.startAnimating()
        loadingView?.center = self.center
        
        self.addSubview(loadingView!)
    }
    
    /// Video is ready to display
    ///
    /// - Parameter videoPlayer: video player
    func playerReady(_ videoPlayer: YouTubePlayerView) {
        self.loadingView?.stopAnimating()
    }
    
    func playerQualityChanged(_ videoPlayer: YouTubePlayerView, playbackQuality: YouTubePlaybackQuality) {
        
    }
    func playerStateChanged(_ videoPlayer: YouTubePlayerView, playerState: YouTubePlayerState) {
        
    }
    
    
}

/// Hero Detail Info Cell
class HeroDetailDetailInfo : UITableViewCell
{
    //Info title
    @IBOutlet weak var detailInfoTitle: UILabel!
    //Info content
    @IBOutlet weak var detailInfo: UILabel!
    //Info iamge
    @IBOutlet weak var detailInfoImage: UIImageView!
    
}

/// All the Hero Info
class HeroIntroInfo
{
    
    /// Hero Image
    var topImage : UIImage
    
    /// Hero Diff
    var difficulty : Int
    
    /// Hero Type
    var heroType : HeroType
    
    /// Hero Name
    var heroName : String
    
    /// Hero Id
    var heroID : Int
    
    /// Hero Ability Array
    var heroAbilityName:[String] = []
    var heroAbilityDescription:[String] = []
    var heroAbilityImage:[UIImage] = []
    
    /// Hero intro video
    var videoUrl:String
    
    
    /// Init a HERO Intro Object
    ///
    /// - Parameters:
    ///   - name: Hero name
    ///   - image: Hero image
    ///   - diff: Hero difficulty
    ///   - type: Hero Type
    ///   - id: Hero ID
    ///   - url: Hero URL
    init(name:String, image:UIImage, diff:Int, type:HeroType, id:Int, url:String) {
        self.topImage = image
        self.heroName = name
        self.heroType = type
        self.difficulty = diff
        self.heroID = id
        self.videoUrl = url
    }
    
    
    /// Add an ablitiy to ablity array
    ///
    /// - Parameters:
    ///   - des: Description
    ///   - name: Ability name
    ///   - img: Ability image
    func setHeroAblity(des:String,name:String,img:UIImage)
    {
        self.heroAbilityName.append(name)
        self.heroAbilityDescription.append(des)
        self.heroAbilityImage.append(img)
    }
}
