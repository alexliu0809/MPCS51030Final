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
import SwiftCharts
import SwiftSVG

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
            self.tempPlayerData.playerName = json["username"].string?.uppercased()
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 45
        
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        let view = UIView()
        view.backgroundColor = UIColor.init(red: 63.0/255.0, green: 96.0/255.0, blue: 159.0/255.0, alpha: 1.0)
        
        let imageView = UIImageView(frame: CGRect(x: 5, y: 5, width: 35, height: 35))
        
        let label = UILabel()
        if (section == 0)
        {
            view.backgroundColor = UIColor.white
            return view
        }
        else if (section == 1)
        {
            label.text = "FEATURED STATS"
            imageView.image = UIImage(named: "SVG-GAME")
        }
        else if (section == 2)
        {
            label.text = "TOP HEROS"
            imageView.image = UIImage(named: "SVG-AWARDS")
        }
        else if (section != 3 + playerData.typeDetails.count) //no footer last one
        {
            label.text =  playerData.typeDetails[section-3].typeName!.uppercased()
            imageView.image = UIImage(named: "SVG-\(label.text!)")
            view.backgroundColor = UIColor.init(red: 185.0/255.0, green: 192.0/255.0, blue: 214.0/255.0, alpha: 1.0)
        }
        label.frame = CGRect(x: 55, y: 5, width: 250, height: 35)
        label.font = UIFont.systemFont(ofSize: 30)
        label.font = label.font.bolditalic()
        label.textColor = UIColor.white
        view.addSubview(label)
        view.addSubview(imageView)
        //self.tableView.tableHeaderView = view
        return view
        
    }
    
    /*
     func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
     if (section == 0)
     {
     return "Overwatch"
     }
     else if (section == 1)
     {
     return "FEATURED STATS"
     }
     else if (section == 2)
     {
     return "TOP HEROS"
     }
     else
     {
     return playerData.typeDetails[section-3].typeName!
     }
     }
     */
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
                self.tempPlayerData.topHeroTime.append(Double(hours)!)
            }
            
            /*** Load Career Stats Data ***/
            
            //self.loadStats(data: [[String : AnyObject]], key: "combat")
            
            let keys = ["combat","deaths","assists","best"]
            
            
            for i in 0..<keys.count{
                let temp = typeDetail()
                temp.typeName = keys[i].uppercased()
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
        
        self.tableView.contentInset = UIEdgeInsets(top: -45, left: 0, bottom: 0, right: 0) //to hide the header
        
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
            
            //cell.featureImage.kf.setImage(with: URL(string:playerData.featureImageURL))
            cell.playerName.text = playerData.playerName!
            cell.gamesWon.text = "\(playerData.gamesWon!) GAMES WON"
            cell.rankIcon.contentMode = .scaleToFill
            cell.rankIcon.kf.setImage(with: URL(string:playerData.rankIconURL!))
            cell.rankPoints.text = playerData.rankPoints!
            cell.backgroundColor = UIColor(patternImage: UIImage(named: "PlayerStats-Bg")!)
            cell.playerIcon.kf.setImage(with: URL(string:playerData.iconImageURL!))
            cell.playerName.sizeToFit()
            cell.gamesWon.adjustsFontSizeToFitWidth = true
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
            generateChart(cell:cell)
            
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerStatsCell", for: indexPath) as! PlayerStats
            //cell.typeName.text = playerData.
            cell.typeDetail.text = playerData.typeDetails[indexPath.section-3].subVal[indexPath.row]
            cell.typeName.text = playerData.typeDetails[indexPath.section-3].subTitle[indexPath.row]
            cell.typeName.sizeToFit()
            //cell.typeDetail.sizeToFit()
            
            return cell
        }
        
    }
    func generateChart(cell:PlayerTopHero)
    {
        
        let chartConfig = BarsChartConfig(
            valsAxisConfig: ChartAxisConfig(from: 0, to: 1.0, by: 0.5)
        )
 
        
        var bars : [(String, Double)] = []
        for i in 0..<5{
            bars.append((playerData.topHerosName[i],playerData.topHeroTime[i]/playerData.topHeroTime.max()!))
        }
        
        print(cell.frame.width)
        print(cell.frame.height)
        let chart = BarsChart(
            frame: CGRect.init(x:0, y:0, width:cell.frame.width, height:cell.frame.height),
            chartConfig: chartConfig,
            xTitle: "Totoal Time",
            yTitle: "Hero Name",
            bars: bars,
            color: UIColor.red,
            barWidth: 20,
            horizontal: true
        )
 
        
     
        cell.addSubview(chart.view)
        cell.chart = chart
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 0)
        {
            return 140
        }
        else if (indexPath.section == 2) //change 1
        {
            return 5 * 100 //playerData.top.count
        }
        else if (indexPath.section == 1)
        {
            return 80
        }
        else
        {
            //return UITableViewAutomaticDimension
            return 45
        }
    }
}

extension UIFont {
    
    func withTraits(traits:UIFontDescriptorSymbolicTraits...) -> UIFont {
        let descriptor = self.fontDescriptor.withSymbolicTraits(UIFontDescriptorSymbolicTraits(traits))
        return UIFont(descriptor: descriptor!, size: 0)
    }
    
    func bold() -> UIFont {
        return withTraits(traits: .traitBold)
    }
    
    func bolditalic() -> UIFont {
        return withTraits(traits: .traitItalic, .traitBold)
    }
    
}
