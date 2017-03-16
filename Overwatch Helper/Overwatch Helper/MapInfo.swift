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


/// Map List
class MapList {
    
    /// List of all map name
    static let nameImageName = ["VOLSKAYA INDUSTRY": "map_volskayaindustry","NEPAL":"map_nepal","ANTARCTICA":"map_antarctica","DORADO":"map_dorado","TEMPLE OF ANUBIS":"map_templeofanubis","OASIS":"map_oasis","NUMBANI":"map_numbani","ROUTE 66":"map_route66","GIBRALTAR":"map_gibraltar","HANAMURA":"map_hanamura","HOLLYWOOD":"map_hollywood","EICHENWALDE":"map_eichenwalde","LIJIANG TOWER":"map_lijiangtower", "ILIOS":"map_Ilios"]
    
    
    
    /// Country of all maps
    static let country = ["VOLSKAYA INDUSTRY" : "Russia", "NEPAL" : "Nepal", "ANTARCTICA" : "Watchpoint", "DORADO" : "Mexico", "TEMPLE OF ANUBIS" : "Egypt", "OASIS" : "Iraq", "NUMBANI" : "Numbani", "ROUTE 66" : "U.S.", "GIBRALTAR" : "Watchpoint", "HANAMURA" : "Japan", "HOLLYWOOD": "U.S.", "EICHENWALDE" : "Germany", "LIJIANG TOWER" : "China", "ILIOS" : "Greek"]
    
}

/// Map Tyoe
///
/// - Assault: Offense Map
/// - Escort: Escort payload
/// - Hybrid: Hybrid Type
/// - Control: Control the point
/// - Arena: 1v1 / 3v3 arena
enum MapType{
    case Assault
    case Escort
    case Hybrid
    case Control
    case Arena
}


/// Map Detail Icon Cell
class MapDetailMapIcon : UITableViewCell
{
    //map image
    @IBOutlet weak var mapImage: UIImageView!
    
    //map name
    @IBOutlet weak var mapName: UILabel!
}


/// Displaying map Basic Info
class MapDetailBasicInfo : UITableViewCell
{
    //Map location
    @IBOutlet weak var location: UILabel!
    //Map Terrain
    @IBOutlet weak var terrain: UILabel!
    //Map Type
    @IBOutlet weak var type: UILabel!
    //Map Flag
    @IBOutlet weak var flag: UIImageView!
    //Location info
    @IBOutlet weak var locTag: UILabel!
    //Map Terrain info
    @IBOutlet weak var terrainTag: UILabel!
    //Map type info
    @IBOutlet weak var typeTag: UILabel!
    
    
}

/// Map detail introduction
class MapDetailDetailInfo : UITableViewCell
{
    //detail content
    @IBOutlet weak var mapBrief: UITextView!
    
}


/// For displaying youtube video on the map
class MapVideoInfo : UITableViewCell, YouTubePlayerDelegate
{
    
    /// Youtube player
    @IBOutlet weak var video: YouTubePlayerView!
    
    //loading
    var loadingView: UIActivityIndicatorView?

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        self.video.delegate = self
        
        //configure indicator view
        loadingView = UIActivityIndicatorView(frame: CGRect(x: 25 , y: 25, width: 50, height: 50))
        
        loadingView?.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        loadingView?.backgroundColor = UIColor.clear
        loadingView?.tintColor = UIColor(hexString: "F89E19")
        loadingView?.startAnimating()
        loadingView?.center = self.center
        
        self.addSubview(loadingView!)
        
    }
    
    
    /// Video is loaded
    ///
    /// - Parameter videoPlayer: player
    func playerReady(_ videoPlayer: YouTubePlayerView) {
        self.loadingView?.stopAnimating() // stop animating
    }
    
    func playerQualityChanged(_ videoPlayer: YouTubePlayerView, playbackQuality: YouTubePlaybackQuality) {
        
    }
    func playerStateChanged(_ videoPlayer: YouTubePlayerView, playerState: YouTubePlayerState) {
        
    }
}


/// Saving Info on each map
class MapIntroInfo
{
    /// map name
    var name: String
    
    /// map image
    var topImage : UIImage
    
    
    /// Map type
    var mapType : String
    
    /// Map location
    var location : String
    
    /// Map terrain
    var terrain: String
    
    /// Flag Image
    var flagImage: UIImage
    
    /// Map Deccription
    var description: String
    
    /// Map Video Url
    var videoURL: String
    
    
    /// Init Map Info
    ///
    /// - Parameters:
    ///   - loacation: map location
    ///   - mapImage: map image
    ///   - flagImage: map flag image
    ///   - type: map type
    ///   - terrain: map terrain
    ///   - name: map name
    ///   - description: map des
    ///   - url: map url
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
