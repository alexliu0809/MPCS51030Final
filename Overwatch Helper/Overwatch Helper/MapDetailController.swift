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
    
    
    var currentMap: MapIntroInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.estimatedRowHeight = 500
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "discover-bg"))
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {

        for i in self.tableView.subviews{
            i.alpha = 0
        }
        DispatchQueue.main.async {
            
            for i in self.tableView.subviews{
                UIView.animate(withDuration: 0.5, animations: {
                    i.alpha = 1
                }, completion: {
                    finish in
                })
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard currentMap != nil
            else
        {
            return 1
        }
        
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "mapIcon", for: indexPath) as! MapDetailMapIcon

            cell.mapImage.image = currentMap?.topImage
            cell.mapName.text = currentMap?.name
            return cell
        }
        else if (indexPath.row == 1) //change2
        {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "mapBasicInfo", for: indexPath) as! MapDetailBasicInfo
            //print("2")
            cell.location.text = currentMap?.location
            cell.terrain.text = currentMap?.terrain
            cell.type.text = currentMap?.mapType
            cell.flag.image = currentMap?.flagImage
            cell.flag.backgroundColor = UIColor.clear
            cell.flag.contentMode = .scaleAspectFit
            cell.locTag.transform = CGAffineTransform(a: 1, b: 0, c: -0.3, d: 1, tx: 0, ty: 0)
            cell.terrainTag.transform = CGAffineTransform(a: 1, b: 0, c: -0.3, d: 1, tx: 0, ty: 0)
            cell.typeTag.transform = CGAffineTransform(a: 1, b: 0, c: -0.3, d: 1, tx: 0, ty: 0)
            cell.locTag.layer.cornerRadius = 5
            cell.locTag.layer.masksToBounds = true
            cell.typeTag.layer.cornerRadius = 5
            cell.terrainTag.layer.masksToBounds = true
            cell.terrainTag.layer.cornerRadius = 5
            cell.typeTag.layer.masksToBounds = true

            return cell
        }
        else if (indexPath.row == 3)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "mapDetailInfo", for: indexPath) as! MapDetailDetailInfo
            //print("3+")
//            cell.backgroundColor = UIColor.green
            cell.mapBrief.text = currentMap?.description
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "mapVideoInfo", for: indexPath) as! MapVideoInfo
            
            cell.video.delegate = cell
            cell.video.loadVideoID((currentMap?.videoURL)!)
            return cell
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.item {
        case 0:
            return 165
        case 1:
            return 230
        case 2:
            return 200
        default:
            return UITableViewAutomaticDimension
        }
    }

}
