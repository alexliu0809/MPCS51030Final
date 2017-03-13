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

class MapList {
    static let nameImageName = ["VOLSKAYA INDUSTRY": "map_volskayaindustry","NEPAL":"map_nepal","ANTARCTICA":"map_antarctica","DORADO":"map_dorado","TEMPLE OF ANUBIS":"map_templeofanubis","OASIS":"map_oasis","NUMBANI":"map_numbani","ROUTE 66":"map_route66","GIBRALTAR":"map_gibraltar","HANAMURA":"map_hanamura","HOLLYWOOD":"map_hollywood","EICHENWALDE":"map_eichenwalde","LIJIANG TOWER":"map_lijiangtower", "ILIOS":"map_Ilios"]
    
    
    
    static let country = ["VOLSKAYA INDUSTRY" : "Russia", "NEPAL" : "Nepal", "ANTARCTICA" : "Watchpoint", "DORADO" : "Mexico", "TEMPLE OF ANUBIS" : "Egypt", "OASIS" : "Iraq", "NUMBANI" : "Numbani", "ROUTE 66" : "U.S.", "GIBRALTAR" : "Watchpoint", "HANAMURA" : "Japan", "HOLLYWOOD": "U.S.", "EICHENWALDE" : "Germany", "LIJIANG TOWER" : "China", "ILIOS" : "Greek"]
    
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
    
    @IBOutlet weak var mapName: UILabel!
}
class MapDetailBasicInfo : UITableViewCell
{
    @IBOutlet weak var location: UILabel!

    @IBOutlet weak var terrain: UILabel!
    
    @IBOutlet weak var type: UILabel!
    
    @IBOutlet weak var flag: UIImageView!
    
    @IBOutlet weak var locTag: UILabel!
    
    @IBOutlet weak var terrainTag: UILabel!
    
    @IBOutlet weak var typeTag: UILabel!
    
    
}
class MapDetailDetailInfo : UITableViewCell
{

    @IBOutlet weak var mapBrief: UITextView!
    
}

class MapVideoInfo : UITableViewCell, YouTubePlayerDelegate
{
    
    @IBOutlet weak var video: YouTubePlayerView!
    var loadingView: UIActivityIndicatorView?

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        self.video.delegate = self
        loadingView = UIActivityIndicatorView(frame: CGRect(x: 25 , y: 25, width: 50, height: 50))
        
        loadingView?.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        loadingView?.backgroundColor = UIColor.clear
        loadingView?.tintColor = UIColor(hexString: "F89E19")
        loadingView?.startAnimating()
        loadingView?.center = self.center
        
        self.addSubview(loadingView!)
    }
    func playerReady(_ videoPlayer: YouTubePlayerView) {
        self.loadingView?.stopAnimating()
    }
    
    func playerQualityChanged(_ videoPlayer: YouTubePlayerView, playbackQuality: YouTubePlaybackQuality) {
        
    }
    func playerStateChanged(_ videoPlayer: YouTubePlayerView, playerState: YouTubePlayerState) {
        
    }
}
class MapIntroInfo
{
    var name: String
    var topImage : UIImage
    var mapType : String
    var location : String
    var terrain: String
    var flagImage: UIImage
    var description: String
    var videoURL: String
    init(loacation: String, mapImage: UIImage, flagImage: UIImage, type: String, terrain: String, name: String, description: String, url: String) {
        self.topImage = mapImage
        self.location = loacation
        self.mapType = type
        self.flagImage = flagImage
        self.terrain = terrain
        self.name = name
        self.description = description
        self.videoURL = url
    }
}
