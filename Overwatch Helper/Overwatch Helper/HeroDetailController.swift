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
    
    
    /// The detail item to display
    var detailItem: HeroIntroInfo? {
        didSet {
            // Update the view.
            NSLog("Dis set Detail Item in Hero Detail Controller")
            self.tableView.reloadData()
        }
        
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
        
        //Dynamic Table View Cell height
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
        NSLog("Did Receive Memory Warning in Hero Detail Controller")
    }
    
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let detailItem = detailItem //if detail item is set
        else
        {
            return 1
        }
        
        return 2 + detailItem.heroAbilityDescription.count //return sections
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeroIconCell", for: indexPath) as! HeroDetailHeroIcon
            
            //Set Hero Information Data
            cell.iconImage.image = detailItem?.topImage
            cell.iconImage.layer.cornerRadius = (cell.iconImage.frame.height)/2
            cell.iconImage.clipsToBounds = true
            return cell
        }
        else if (indexPath.row == 2 + (detailItem?.heroAbilityDescription.count)! - 1) //change2
        {
            //Display Herp Video in the end
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeroBasicCell", for: indexPath) as! HeroDetailBasicInfo
           
            cell.youtubePlayer.delegate = cell
            cell.youtubePlayer.loadVideoID(detailItem!.videoUrl)
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeroDetailCell", for: indexPath) as! HeroDetailDetailInfo
            
            //Display Hero Abilities (multiple cell)
            cell.detailInfo.text = detailItem?.heroAbilityDescription[indexPath.row-1] //change3
            cell.detailInfoTitle.text = detailItem?.heroAbilityName[indexPath.row-1]
            cell.detailInfoImage.image = detailItem?.heroAbilityImage[indexPath.row-1]
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 0)
        {
            return 165 //Hero Icon
        }
        else if (indexPath.row == 2 + (detailItem?.heroAbilityDescription.count)! - 1) //change 1, original 1
        {
            return 165 //Video
        }
        else
        {
            return UITableViewAutomaticDimension //Abilities
        }
    }
}
