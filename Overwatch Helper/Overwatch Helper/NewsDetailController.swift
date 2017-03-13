//
//  NewsDetailController.swift
//  Overwatch Helper
//
//  Created by Benyan Gong on 3/5/17.
//  Copyright © 2017 Alex&Ben. All rights reserved.
//

import Foundation
import UIKit

class NewsDetailController: UIViewController, UIWebViewDelegate{
    @IBOutlet weak var webView: UIWebView!
    var loadingView: UIActivityIndicatorView?
    
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
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        self.loadingView?.startAnimating()
    }
    
    //finish webview loading
    func webViewDidFinishLoad(_ webView: UIWebView) {
        UIView.animate(withDuration: 1, animations: {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        })
        loadingView?.stopAnimating()
    }
    
    //webview error, shows the alert
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        let alert = UIAlertController(title: "Connection Failed", message: "Oops...Something wrong", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: {
            action in
        })
        alert.addAction(action)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
        
        //fade out the indicator if shows alert
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        self.loadingView?.stopAnimating()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "NewsDetail"
        // Do any additional setup after loading the view, typically from a nib.
        webView.isOpaque = false
        self.webView.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "discover-bg"))
        
        webView.delegate = self
        loadingView = UIActivityIndicatorView(frame: CGRect(x: 25 , y: 25, width: 50, height: 50))
        
        loadingView?.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        loadingView?.backgroundColor = UIColor.clear
        loadingView?.tintColor = UIColor(hexString: "F89E19")
        loadingView?.startAnimating()
        loadingView?.center = self.view.center
        
        
        webView.addSubview(loadingView!)
        
        self.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if currentReachability != .reachableViaWiFi {
            let message = (currentReachability == .reachableViaWWAN ? "Better to watch under Wi-Fi connection" : "Internet connection required")
            let alert = UIAlertController(title: "This page contains video", message: message, preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK", style: .default, handler: {
                action in
            })
            alert.addAction(action)
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: {})
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
