//
//  NewsDetailController.swift
//  Overwatch Helper
//
//  Created by Benyan Gong on 3/5/17.
//  Copyright © 2017 Alex&Ben. All rights reserved.
//

import Foundation
import UIKit

class NewsDetailController: UIViewController{
    @IBOutlet weak var webView: UIWebView!
    
    var detailItem : NewsData?{
        didSet{
            self.reloadData()
        }
    }
    
    func reloadData()
    {
        guard let item = detailItem
            else
        {
            return
        }
        
        guard let url = URL(string: item.url)
            else
        {
            return
        }
        let urlRequest = URLRequest(url: url)
        guard let web = self.webView
        else
        {
            return
        }
        web.loadRequest(urlRequest)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "NewsDetail"
        // Do any additional setup after loading the view, typically from a nib.
        
        self.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
