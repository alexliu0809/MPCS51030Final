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
    @IBOutlet weak var newsTable: UITableView!
    
    var newsArray:[NewsData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //newsTable.delegate = self
        self.newsTable.delegate = self
        self.newsTable.dataSource = self
        self.navigationItem.title = "News"
        
        let tempImageView = UIImageView(image: UIImage(named: "News-Bg"))
        tempImageView.frame = self.newsTable.frame
        tempImageView.contentMode = .scaleToFill
        self.newsTable.backgroundView = tempImageView;

        self.newsTable.separatorColor = UIColor.orange
        self.newsTable.layer.borderWidth = 1.2
        self.newsTable.layer.borderColor = UIColor.orange.cgColor
        
        //self.newsTable.
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //https://raw.githubusercontent.com/alexliu0809/MPCS51030Final/Dev/JSON/News.json
        SharedNetworking.Shared.fetchJSON(URLString: "https://rawgit.com/alexliu0809/MPCS51030Final/Dev/JSON/News.json", completion: { (data) in
            //print(data)
            let json = data as! [[String:AnyObject]]
            //print(json.count)
            
            var tempData:[NewsData] = []
            for i in 0..<json.count
            {
                tempData.append(NewsData.init(title: json[i]["title"] as! String, url: json[i]["url"] as! String, imageUrl: json[i]["image"] as! String))
            }
            
            self.newsArray = tempData
            //print(self.newsArray[0].newsTitle)
            //print(self.newsArray[1].newsTitle)
            //print(self.newsArray[2].newsTitle)
            self.newsTable.reloadData()
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsTableViewCell
        // Configure the cell...
        //set labels and images
        cell.newsContent.text = newsArray[indexPath.row].newsTitle
        //print(cell.newsContent.text)
        //print(indexPath.row)
        cell.backgroundColor = UIColor.clear
        let url = URL(string:newsArray[indexPath.row].imageUrl)
        cell.newsImage.kf.setImage(with: url)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "SegueNewsDetail")
        {
            if let indexPath = self.newsTable.indexPathForSelectedRow {
                let info = newsArray[indexPath.row]
                let controller = segue.destination as! NewsDetailController
                controller.detailItem = info
                //controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                //controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
}
