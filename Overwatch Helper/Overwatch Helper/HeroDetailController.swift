//
//  HeroDetailController.swift
//  Overwatch Helper
//
//  Created by Benyan Gong on 3/5/17.
//  Copyright © 2017 Alex&Ben. All rights reserved.
//

import Foundation
import UIKit
import YouTubePlayer_Swift

class HeroDetailController:UITableViewController{
    
    var detailItem: HeroIntroInfo? {
        didSet {
            // Update the view.
            print("Did Set")
            self.tableView.reloadData()
        }
        
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 165
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("Warning")
    }
    
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let detailItem = detailItem
        else
        {
            return 1
        }
        
        return 2 + detailItem.heroAbilityDescription.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeroIconCell", for: indexPath) as! HeroDetailHeroIcon
            //print("1")
            //cell.backgroundColor = UIColor.red
            //print(detailItem)
            cell.iconImage.image = detailItem?.topImage
            cell.iconImage.layer.cornerRadius = (cell.iconImage.frame.height)/2
            cell.iconImage.clipsToBounds = true
            return cell
        }
        else if (indexPath.row == 2 + (detailItem?.heroAbilityDescription.count)! - 1) //change2
        {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeroBasicCell", for: indexPath) as! HeroDetailBasicInfo
            //print("2")
            //cell.backgroundColor = UIColor.gray
            cell.youtubePlayer.delegate = cell
            cell.youtubePlayer.loadVideoID(detailItem!.videoUrl)
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeroDetailCell", for: indexPath) as! HeroDetailDetailInfo
            //print("3+")
            //cell.backgroundColor = UIColor.green
            cell.detailInfo.text = detailItem?.heroAbilityDescription[indexPath.row-1] //change3
            cell.detailInfoTitle.text = detailItem?.heroAbilityName[indexPath.row-1]
            cell.detailInfoImage.image = detailItem?.heroAbilityImage[indexPath.row-1]
            return cell
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 0)
        {
            return 165
        }
        else if (indexPath.row == 2 + (detailItem?.heroAbilityDescription.count)! - 1) //change 1, original 1
        {
            return 165
        }
        else
        {
            return UITableViewAutomaticDimension
        }
    }
}
