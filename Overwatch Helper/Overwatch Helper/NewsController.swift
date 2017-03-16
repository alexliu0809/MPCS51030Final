//
//  NewsController.swift
//  Overwatch Helper
//
//  Created by Benyan Gong on 3/5/17.
//  Copyright © 2017 Alex&Ben. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class NewsController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var newsTable: UITableView! //table view that presents news
    
    var newsArray:[NewsData] = [] //news data
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //newsTable.delegate = self
        self.newsTable.delegate = self
        self.newsTable.dataSource = self
        self.navigationItem.title = "News"
        
        //Crate Image for background
        let tempImageView = UIImageView(image: UIImage(named: "News-Bg"))
        tempImageView.frame = self.view.frame
        tempImageView.contentMode = .scaleToFill
        tempImageView.alpha = 1.0
        //self.newsTable.backgroundView = tempImageView;
        self.view.addSubview(tempImageView)
        
        //Create a mask for image
        let tempView = UIView(frame: self.view.frame)
        tempView.backgroundColor = UIColor.black
        tempView.alpha = 0.6
        self.view.addSubview(tempView)
        
        //Set bg color to clear so that the image for bg can be shown
        self.newsTable.backgroundColor = UIColor.clear
        self.view.bringSubview(toFront: self.newsTable)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        NSLog("Fetching New from : https://rawgit.com/alexliu0809/MPCS51030Final/Dev/JSON/News.json")
        SharedNetworking.Shared.fetchJSON(URLString: "https://rawgit.com/alexliu0809/MPCS51030Final/Dev/JSON/News.json", completion: { (data) in
            NSLog("News Data Retreived:\(data)")
            
            let json = data as! [[String:AnyObject]]
            
            //save the news data to a temp array
            var tempData:[NewsData] = []
            for i in 0..<json.count
            {
                tempData.append(NewsData.init(title: json[i]["title"] as! String, url: json[i]["url"] as! String, imageUrl: json[i]["image"] as! String))
            }
            
            self.newsArray = tempData //copy to the real one
            
            self.newsTable.reloadData()
            
            
        })
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsTableViewCell
        
        //Configure news array
        cell.newsContent.text = newsArray[indexPath.row].newsTitle //set content
        cell.backgroundColor = UIColor.clear
        
        //Use Third Party Lib To get Image
        let url = URL(string:newsArray[indexPath.row].imageUrl)
        cell.newsImage.kf.setImage(with: url)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "SegueNewsDetail")
        {
            NSLog("Segue Triggered, to News Detail")
            
            if let indexPath = self.newsTable.indexPathForSelectedRow {
                //pass the data to detail
                let info = newsArray[indexPath.row]
                let controller = segue.destination as! NewsDetailController
                controller.detailItem = info
                
            }
        }
    }
}
