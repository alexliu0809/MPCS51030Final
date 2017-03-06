//
//  NewsController.swift
//  Overwatch Helper
//
//  Created by Benyan Gong on 3/5/17.
//  Copyright © 2017 Alex&Ben. All rights reserved.
//

import Foundation
import UIKit

class NewsController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var newsTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //newsTable.delegate = self
        self.newsTable.delegate = self
        self.newsTable.dataSource = self
        self.navigationItem.title = "News"
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsTableViewCell
        // Configure the cell...
        //set labels and images
        cell.newsContent.text = "123"
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "SegueNewsDetail")
        {
            
        }
    }
}
