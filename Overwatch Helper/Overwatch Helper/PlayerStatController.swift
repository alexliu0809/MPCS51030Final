//
//  PlayerStatController.swift
//  Overwatch Helper
//
//  Created by Benyan Gong on 3/5/17.
//  Copyright © 2017 Alex&Ben. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Kingfisher

class PlayerStatController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    @IBOutlet weak var tableView: UITableView!
    
    var playerData:PlayerStatatistic = PlayerStatatistic()
    var tempPlayerData:PlayerStatatistic = PlayerStatatistic()
    
    var playerAccount:String?{
        didSet{
            self.loadBasicInfo()
        }
    }
    
    func loadBasicInfo()
    {
        let str = "https://ow-api.herokuapp.com/profile/pc/us/\(playerAccount!)"
        //let str = "https://ow-api.herokuapp.com/profile/pc/us/dfas"
        SharedNetworking.Shared.fetchData(URLString: str, completion: {(profile) in
            //print(profile)
            
            
            var json = JSON(data:profile!)
            if (json.count == 0)
            {
                return
            }
            self.tempPlayerData = PlayerStatatistic()
            
            //json[0]["fasfd"].string
            self.tempPlayerData.playerName = json["username"].string
            self.tempPlayerData.iconImageURL = json["portrait"].string
            self.tempPlayerData.playerLevel = json["level"].int
            
            
            let quickWins = json["games"]["quickplay"]["wins"].string
            let comWins = json["games"]["competitive"]["wins"].string
            let totalWins = Int(quickWins!)! + Int(comWins!)!
            self.tempPlayerData.gamesWon = "\(totalWins)"
            
            
            self.tempPlayerData.rankPoints = json["competitive"]["rank"].string
            self.tempPlayerData.rankIconURL = json["competitive"]["rank_img"].string
            
            
            self.loadDetailInfo()
            
            self.tableView.rowHeight = UITableViewAutomaticDimension
            self.tableView.estimatedRowHeight = 80
            
        })
    }
    
    func loadDetailInfo()
    {
        let str = "https://ow-api.herokuapp.com/stats/pc/us/\(playerAccount!)"
        SharedNetworking.Shared.fetchData(URLString: str, completion: {(profile) in
            
            var json = JSON(data:profile!)
            if (json.count == 0)
            {
                return
            }
            
            /*** Load Feature Data ***/
            for i in 0..<json["stats"]["average"]["quickplay"].count{
                self.tempPlayerData.featureDescription.append(json["stats"]["average"]["quickplay"][i]["title"].string!)
                self.tempPlayerData.featureNumbers.append(json["stats"]["average"]["quickplay"][i]["value"].string!)
            }
            
            /*** Load Top Hero Data ***/
            for i in 0..<json["stats"]["top_heroes"]["quickplay"].count{
                self.tempPlayerData.topHerosName.append(json["stats"]["top_heroes"]["quickplay"][i]["hero"].string!)
                var hours = json["stats"]["top_heroes"]["quickplay"][i]["played"].string!
                hours = hours.components(separatedBy: " ")[0]
                self.tempPlayerData.topHeroTime.append(Int(hours)!)
            }
            
            /*** Load Career Stats Data ***/
            
            //self.loadStats(data: [[String : AnyObject]], key: "combat")
            
            let keys = ["combat","deaths","assists","best"]
            
            
            for i in 0..<keys.count{
                let temp = typeDetail()
                temp.typeName = keys[i]
                for j in 0..<json["stats"][keys[i]]["quickplay"].count
                {
                    //self.playerData.
                    temp.subTitle.append(json["stats"][keys[i]]["quickplay"][j]["title"].string!)
                    temp.subVal.append(json["stats"][keys[i]]["quickplay"][j]["value"].string!)
                }
                self.tempPlayerData.typeDetails.append(temp)
            }
            self.playerData = self.tempPlayerData
            self.tableView.reloadData()
        })
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if (playerData.playerName != nil)
        {
            return 3 + playerData.typeDetails.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return 1
        if (section == 0)
        {
            if (playerData.playerName != nil)
            {
                return 1
            }
            else
            {
                return 0
            }
        }
        else if (section == 1)
        {
            if (playerData.featureNumbers.count == 0)
            {
                return 0
            }
            else
            {
                return playerData.featureNumbers.count
            }
        }
        else if (section == 2)
        {
            if (playerData.topHeroTime.count == 0)
            {
                return 0
            }
            else
            {
                return 1
            }
        }
        else
        {
            if (playerData.typeDetails.count == 0)
            {
                return 0
            }
            else
            {
                return playerData.typeDetails[section-3].subTitle.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerHeaderCell", for: indexPath) as! PlayerHeader

            cell.featureImage.kf.setImage(with: URL(string:playerData.featureImageURL))
            cell.playerName.text = playerData.playerName!
            cell.gamesWon.text = playerData.gamesWon!
            cell.rankIcon.contentMode = .scaleToFill
            cell.rankIcon.kf.setImage(with: URL(string:playerData.rankIconURL!))
            cell.rankPoints.text = playerData.rankPoints!
            
            return cell
        }
        else if (indexPath.section == 1) //change2
        {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerFeatureCell", for: indexPath) as! PlayerFeature
            //print("2")
            cell.backgroundColor = UIColor.gray
            cell.featureDescription.text = playerData.featureDescription[indexPath.row]
            cell.featureNumber.text = "\(playerData.featureNumbers[indexPath.row])"
            //cell.youtubePlayer.loadVideoID(detailItem!.videoUrl)
            return cell
        }
        else if (indexPath.section == 2)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerTopHeroCell", for: indexPath) as! PlayerTopHero
            //print("3+")
            //cell.backgroundColor = UIColor.green
            //cell.detailInfo.text = detailItem?.heroAbilityDescription[indexPath.row-2] //change3
            //cell.detailInfoTitle.text = detailItem?.heroAbilityName[indexPath.row-2]
            //cell.detailInfoImage.image = detailItem?.//heroAbilityImage[indexPath.row-2]
            return cell
        }
        else
        {
           let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerStatsCell", for: indexPath) as! PlayerStats
           //cell.typeName.text = playerData.
            cell.typeDetail.text = playerData.typeDetails[indexPath.section-3].subVal[indexPath.row]
            cell.typeName.text = playerData.typeDetails[indexPath.section-3].subTitle[indexPath.row]
            
            
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 0)
        {
            return 116
        }
        else if (indexPath.section == 2) //change 1
        {
            return UITableViewAutomaticDimension
        }
        else
        {
            //return UITableViewAutomaticDimension
            return 80
        }
    }
}
