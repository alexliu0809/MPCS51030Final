//
//  MapDetailController.swift
//  Overwatch Helper
//
//  Created by Benyan Gong on 3/5/17.
//  Copyright © 2017 Alex&Ben. All rights reserved.
//

import Foundation
import UIKit

class MapDetailController: UITableViewController{
    
    var currentMapName: String = ""
    var icon: UIImage = UIImage()
    var detail: String = ""
    var loc: String = ""
    var terrain: String = ""
    var type: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        icon = #imageLiteral(resourceName: "map_oasis")
        detail = "Liangtower is a xxxxx"
        loc = "China"
        terrain = "City"
        type = "Escort"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard currentMapName != ""
            else
        {
            return 1
        }
        
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "mapIcon", for: indexPath) as! MapDetailMapIcon

            cell.mapImage.image = UIImage(named: MapList.nameImageName[currentMapName]!)
            cell.mapName.text = currentMapName
            return cell
        }
        else if (indexPath.row == 1) //change2
        {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "mapBasicInfo", for: indexPath) as! MapDetailBasicInfo
            //print("2")
            cell.location.text = MapList.country[currentMapName]
            cell.terrain.text = terrain
            cell.type.text = type
            cell.flag.image = UIImage(named: MapList.country[currentMapName]!)
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "mapDetailInfo", for: indexPath) as! MapDetailDetailInfo
            //print("3+")
//            cell.backgroundColor = UIColor.green
            cell.mapBrief.text = detail
            return cell
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 165
    }

}
