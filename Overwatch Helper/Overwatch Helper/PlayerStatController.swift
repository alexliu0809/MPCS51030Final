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
    
    /// Table View
    @IBOutlet weak var tableView: UITableView!
    
    
    /// real player data
    var playerData:PlayerStatatistic = PlayerStatatistic()
    
    
    /// temp Data for retreiving data from json
    var tempPlayerData:PlayerStatatistic = PlayerStatatistic()
    
    
    /// Loading view
    var loadingView: UIActivityIndicatorView?
    
    
    /// Play Account Info
    var playerAccount:String?{
        didSet{
            NSLog("Did Set Player Account")
            
            self.loadBasicInfo()
        }
    }
    
    
    /// Present an alert
    ///
    /// - Parameters:
    ///   - title: alert title
    ///   - Msg: alert msg
    func presentAlert(title:String,Msg:String)
    {
        let alert = UIAlertController(title: title, message: Msg, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: {
            action in
            //self.dismi
        })
        alert.addAction(action)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }

    }
    
    
    /// Load Player Basic Info from JSON
    func loadBasicInfo()
    {
        
        let str = "https://ow-api.herokuapp.com/profile/pc/us/\(playerAccount!)"
        //let str = "https://ow-api.herokuapp.com/profile/pc/us/dfas"
        
        loadingView?.startAnimating()
        SharedNetworking.Shared.fetchData(URLString: str, completion: {(profile) in
            //print(profile)
            self.loadingView?.stopAnimating()
            
            //Player Data Not retrived
            if (profile == nil)
            {
                self.presentAlert(title: "Connection Failed", Msg: "Please check your network and your input:Id#Number")
                return
            }
            
            
            //Player Data Not retrived
            var json = JSON(data:profile!)
            if (json.count == 0)
            {
                self.presentAlert(title: "No Data Retreived", Msg: "Oops...Something wrong")
                return
            }
            
            self.tempPlayerData = PlayerStatatistic()
            
            //json[0]["fasfd"].string
            //Parse The Json
            self.tempPlayerData.playerName = json["username"].string?.uppercased()
            self.tempPlayerData.iconImageURL = json["portrait"].string
            self.tempPlayerData.playerLevel = json["level"].int
            
            
            let quickWins = json["games"]["quickplay"]["wins"].string
            let comWins = json["games"]["competitive"]["wins"].string
            let totalWins = Int(quickWins!)! + Int(comWins!)!
            self.tempPlayerData.gamesWon = "\(totalWins)"
            
            
            self.tempPlayerData.rankPoints = json["competitive"]["rank"].string
            self.tempPlayerData.rankIconURL = json["competitive"]["rank_img"].string
            
            //reload tableview
            self.loadDetailInfo()
            
            //autosize tableview
            self.tableView.rowHeight = UITableViewAutomaticDimension
            self.tableView.estimatedRowHeight = 80
            
        })
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 45
        
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        //Redefine Sectjion Header
        let view = UIView() //Background Color View
        view.backgroundColor = UIColor.init(red: 63.0/255.0, green: 96.0/255.0, blue: 159.0/255.0, alpha: 1.0)
        
        let imageView = UIImageView(frame: CGRect(x: 5, y: 5, width: 35, height: 35)) //Section Header Image
        
        let label = UILabel() //Section Header Title
        
        //Based on section set everything.
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
        
        //Set up label
        label.frame = CGRect(x: 55, y: 5, width: 250, height: 35)
        label.font = UIFont.systemFont(ofSize: 30)
        label.font = label.font.bolditalic()
        label.textColor = UIColor.white
        
        //Add All
        view.addSubview(label)
        view.addSubview(imageView)
        //self.tableView.tableHeaderView = view
        return view
        
    }
    
    
    /// If the Data Contains the following keywords, extract it from json
    ///
    /// - Parameter str: the data string
    /// - Returns: whether to extract it
    func ifContains(str:String) -> Bool{
        //return false
        if (str.contains("Objective Time"))
        {
            return false
        }
        if (str.contains("Deaths"))
        {
            return false
        }
        if (str.contains("Damage Done"))
        {
            return false
        }
        if (str.contains("Healing Done"))
        {
            return false
        }
        if (str.contains("Objective Kills"))
        {
            return false
        }
        if (str.contains("Eliminations"))
        {
            return false
        }
        return true
    }
    
    
    /// Load Player Detail Info
    func loadDetailInfo()
    {
        let str = "https://ow-api.herokuapp.com/stats/pc/us/\(playerAccount!)"
        SharedNetworking.Shared.fetchData(URLString: str, completion: {(profile) in
            NSLog("User Profile Retreived: \(profile!)")
            var json = JSON(data:profile!)
            if (json.count == 0)
            {
                return
            }
            
            /*** Load Feature Data ***/
            for i in 0..<json["stats"]["average"]["quickplay"].count{
                if (self.ifContains(str: json["stats"]["average"]["quickplay"][i]["title"].string!))
                {
                    continue
                }
                self.tempPlayerData.featureDescription.append(json["stats"]["average"]["quickplay"][i]["title"].string!)
                self.tempPlayerData.featureNumbers.append(json["stats"]["average"]["quickplay"][i]["value"].string!)
            }
            
            /*** Load Top Hero Data ***/
            for i in 0..<json["stats"]["top_heroes"]["quickplay"].count{
            
                let name = json["stats"]["top_heroes"]["quickplay"][i]["hero"].string!
                //self.tempPlayerData.topHerosName.append()
                let hours = json["stats"]["top_heroes"]["quickplay"][i]["played"].string!
                if (hours == "--") // no data
                {
                    continue
                }
                var time = Double(hours.components(separatedBy: " ")[0])!
                let type = hours.components(separatedBy: " ")[1]
                if (type == "seconds")
                {
                    time = 1.0/60.0
                }
                else if (type == "minutes")
                {
                    time = time / 60.0
                }
                //NSLog("\(name)")
                //NSLog("\(time)")
                
                self.tempPlayerData.topHeros.append(topInfo.init(name: name, time: time))
            }

            self.tempPlayerData.topHeros = self.tempPlayerData.topHeros.sorted(by:{$0.topHeroTime > $1.topHeroTime})

            
            /*** Load Career Stats Data ***/
            
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
            
            self.tableView.isHidden = false

            self.tableView.reloadData()
        })
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.isHidden = true
        self.view.backgroundColor = UIColor.black
        
        self.tableView.contentInset = UIEdgeInsets(top: -45, left: 0, bottom: 0, right: 0) //to hide the header
        
        
    
            loadingView = UIActivityIndicatorView(frame: CGRect(x: 25 , y: 25, width: 50, height: 50))
            
            loadingView?.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
            loadingView?.backgroundColor = UIColor.clear
            loadingView?.tintColor = UIColor(hexString: "F89E19")
            loadingView?.startAnimating()
            loadingView?.center = self.view.center
        self.view.addSubview(loadingView!)
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
        
        //Baased on section return rows
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
            if (playerData.topHeros.count == 0)
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
            
            //could be nil
            //Set Rank Info
            if (playerData.rankIconURL != nil)
            {
                cell.rankIcon.kf.setImage(with: URL(string:playerData.rankIconURL!))
            }
            if (playerData.rankPoints != nil)
            {
                cell.rankPoints.text = playerData.rankPoints!
            }
            else
            {
                cell.rankPoints.text = ""
            }
            
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
            
            //Set Feature Info
            cell.backgroundColor = UIColor.gray
            cell.featureDescription.text = playerData.featureDescription[indexPath.row]
            cell.featureNumber.text = "\(playerData.featureNumbers[indexPath.row])"
            cell.featureImg.image = UIImage(named: "SVG-\(indexPath.row)")
            
            return cell
        }
        else if (indexPath.section == 2)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerTopHeroCell", for: indexPath) as! PlayerTopHero

            generateChart(cell:cell) //Generate a chart
            
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerStatsCell", for: indexPath) as! PlayerStats
            
            //Set Other Type Info
            cell.typeDetail.text = playerData.typeDetails[indexPath.section-3].subVal[indexPath.row]
            cell.typeName.text = playerData.typeDetails[indexPath.section-3].subTitle[indexPath.row]
            cell.typeName.sizeToFit()
            
            return cell
        }
        
    }
    
    
    /// Generate a CHART based on data
    ///
    /// - Parameter cell: cell to display the chart
    func generateChart(cell:PlayerTopHero)
    {
        
        
        var bars : [(String, Double)] = [] //date
        
        //5 bars
        var count = 0
        if playerData.topHeros.count >= 5
        {
            count = 5
        }
        else
        {
            count = playerData.topHeros.count
        }
        
        //add data
        for i in (0..<count).reversed(){
            bars.append((playerData.topHeros[i].topHerosName,playerData.topHeros[i].topHeroTime))
        
        }
        
        //initialize dataset
        let charSet = ChartSettings()
        charSet.leading = 10
        charSet.trailing = 10
        charSet.top = 10
        charSet.bottom = 10
        let chartConfig = BarsChartConfig(
            chartSettings: charSet,
            valsAxisConfig: ChartAxisConfig(from: 0, to: playerData.topHeros[0].topHeroTime, by: playerData.topHeros[0].topHeroTime/3.0),
            xAxisLabelSettings: ChartLabelSettings(font: UIFont.systemFont(ofSize: 17), fontColor: UIColor.blue)
            
        )
    
        //create chart
        let chart = BarsChart(
            frame: CGRect.init(x:0, y:0, width:cell.frame.width, height:cell.frame.height),
            chartConfig: chartConfig,
            xTitle: "Totoal Time",
            yTitle: "Hero Name",
            bars: bars,
            color: UIColor.red,
            barWidth: 10,
            horizontal: true
        )
        
        //chart.view.color
 
        
        //add and show
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


// MARK: - Externsion
extension UIFont {
    
    /*Extent UI Font*/
    //With TRAITS
    func withTraits(traits:UIFontDescriptorSymbolicTraits...) -> UIFont {
        let descriptor = self.fontDescriptor.withSymbolicTraits(UIFontDescriptorSymbolicTraits(traits))
        return UIFont(descriptor: descriptor!, size: 0)
    }
    
    //bold
    func bold() -> UIFont {
        return withTraits(traits: .traitBold)
    }
    
    //bolditalic
    func bolditalic() -> UIFont {
        return withTraits(traits: .traitItalic, .traitBold)
    }
    
}
