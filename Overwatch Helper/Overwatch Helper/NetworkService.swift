//
//  NetworkService.swift
//  Overwatch Helper
//
//  Created by Benyan Gong on 3/5/17.
//  Copyright © 2017 Alex&Ben. All rights reserved.
//

import Foundation
import Alamofire
import UIKit


/// Network Manager Class
class SharedNetworking{
    
    /// Shared Instance for networking
    static let Shared = SharedNetworking()
    
    
    /// For Fetching JSON using Alamofire from url
    ///
    /// - Parameters:
    ///   - URLString: URL for request
    ///   - completion: completion handler
    func fetchJSON(URLString :String, completion: @escaping (Any?) -> ()){
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true //set indicator
        
        let headers = ["Accept" : "application/json"]
        NSLog("Fetching Data with URL: \(URLString)")
        
        //request
        Alamofire.request(URLString, headers: headers).responseJSON(completionHandler: {
            response in
            
            //check data
            guard let JSON = response.result.value, response.result.error == nil else {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                return
            }
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false //set indicator
            
            NSLog("JSON Fetched: \(JSON)")
            completion(JSON)
        })
    }
    
    
    /// Fetching some raw data from url
    ///
    /// - Parameters:
    ///   - URLString: URL for request
    ///   - completion: completion handler
    func fetchData(URLString :String, completion: @escaping (Data?) -> ()){
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true //Set indicator
        
        let headers = ["Accept" : "application/json"]
        NSLog("Fetching Data with URL: \(URLString)")
        
        Alamofire.request(URLString, headers: headers).responseJSON(completionHandler: {
            response in
            
            //check data
            guard let JSON = response.data, response.result.error == nil else {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                completion(nil)
                return
            }
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false//Set indicator
            
            NSLog("JSON Fetched: \(JSON)")
            completion(JSON)
        })
    }
    
   
    /// Fetch Image from url
    ///
    /// - Parameters:
    ///   - URLString: URL For request
    ///   - completion: completion handler
    func fetchImage(URLString :String, completion: @escaping (UIImage?) -> ()){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true //set indicator
        
        NSLog("Fetching Data with URL: \(URLString)")
        
        Alamofire.request(URLString).responseData(completionHandler: {
            response in
            
            //check data
            guard let data = response.result.value, response.result.error == nil else {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                return
            }
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false//set indicator
            
            //return image
            let img = UIImage(data: data)
            completion(img)
        })
    }
    
}
