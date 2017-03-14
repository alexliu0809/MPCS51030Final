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
    
    /// UIWebView
    @IBOutlet weak var webView: UIWebView!
    
    
    /// Indicator View
    var loadingView: UIActivityIndicatorView?
    
    
    /// The News Data to display
    var detailItem : NewsData?{
        didSet{
            self.reloadData()
        }
    }
    
    
    /// Relaod web view when news data is ready
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
        NSLog("Web Load URL:\(urlRequest)")
        web.loadRequest(urlRequest)
    }
    
    
    /// Web did start loading
    ///
    /// - Parameter webView: the web view
    func webViewDidStartLoad(_ webView: UIWebView) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true //activate the indicator
        self.loadingView?.startAnimating() //start showing loading screen
    }
    
    /// Finish webview loading
    ///
    /// - Parameter webView: the web view
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        UIView.animate(withDuration: 1, animations: {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false //deactivate the indicator
        })
        
        loadingView?.stopAnimating() //stop showing loading
    }
    
    
    /// webview error, shows the alert
    ///
    /// - Parameters:
    ///   - webView: the webview
    ///   - error: the error
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        let alert = UIAlertController(title: "Connection Failed", message: "Oops...Something wrong", preferredStyle: .alert)
        //create alert
        
        let action = UIAlertAction(title: "OK", style: .default, handler: {
            action in
        })
        alert.addAction(action)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil) //display alert
        }
        
        //fade out the indicator if shows alert
        UIApplication.shared.isNetworkActivityIndicatorVisible = false //disable indicator
        
        self.loadingView?.stopAnimating() //stop loading view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "NewsDetail"
        // Do any additional setup after loading the view, typically from a nib.
        
        //Set Webview bg
        webView.isOpaque = false
        self.webView.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "discover-bg"))
        
        webView.delegate = self
        loadingView = UIActivityIndicatorView(frame: CGRect(x: 25 , y: 25, width: 50, height: 50))
        
        //Set loading view
        loadingView?.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        loadingView?.backgroundColor = UIColor.clear
        loadingView?.tintColor = UIColor(hexString: "F89E19")
        loadingView?.startAnimating()
        loadingView?.center = self.view.center
        
        //add load view
        webView.addSubview(loadingView!)
        
        //try to reloaod data
        self.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //if is not wifi
        if currentReachability != .reachableViaWiFi {
            
            //display alert
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
