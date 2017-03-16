//
//  MapIntroController.swift
//  Overwatch Helper
//
//  Created by Benyan Gong on 3/5/17.
//  Copyright © 2017 Alex&Ben. All rights reserved.
//

import Foundation
import UIKit


/// <#Description#>
var mapArray: [MapIntroInfo] = []

class MapIntroController: UIViewController{
    
    
    /// Scrollview as base view
    @IBOutlet weak var scrollView: UIScrollView!

    ///Map list
    var mapList : [MapCell] = []
    var selectedMap : MapIntroInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "discover-bg"))
        scrollView.contentSize = CGSize(width: 375, height: 750)
        
        //customize all map views
        //odd left, even right
        for i in 0...6 {
            let width1 = i % 2 == 0 ? 275 : 200
            let width2 = Int(self.view.frame.width) + 100 - width1
            
            let newMap1 = MapCell(frame: CGRect(x: -50, y: -50 + i*120, width: width1, height: 100), mapArray[2*i], true, 2*i)
            let ges1 = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            newMap1.addGestureRecognizer(ges1)
            self.mapList.append(newMap1)
            self.scrollView.addSubview(newMap1)
            
            
            let newMap2 = MapCell(frame: CGRect(x: width1 - 40, y: -50 + i*120, width: width2, height: 100), mapArray[2*i+1], false, 2*i+1)
            let ges2 = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            newMap2.addGestureRecognizer(ges2)
            self.mapList.append(newMap2)
            self.scrollView.addSubview(newMap2)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //move map views inside
    override func viewWillAppear(_ animated: Bool) {
        for i in 0...13 {
            if i % 2 == 0 {
                UIView.animate(withDuration: 0.7, animations: {
                    self.mapList[i].center.x = -50 + self.mapList[i].frame.width / 2
                })
            }else{
                UIView.animate(withDuration: 0.7, animations: {
                    self.mapList[i].center.x = self.view.frame.width+60 - self.mapList[i].frame.width / 2
                })
            }
        }
        
    }
    
    
    /// <#Description#>
    ///
    /// - Parameter recognizer: <#recognizer description#>
    func handleTap(_ recognizer : UITapGestureRecognizer){
        
        NSLog("Tapped Gesture Triggered in Map Intro Controller")
        if let selectedCell = (recognizer.view as! MapCell?) {
            selectedMap = mapArray[selectedCell.number]
        }else{
            return
        }
        for i in 0...13 {
            if i % 2 == 0 {
                UIView.animate(withDuration: 0.7, animations: {
                    self.mapList[i].center.x = -738
                })
            }else{
                UIView.animate(withDuration: 0.7, animations: {
                    self.mapList[i].center.x = 1113
                })
            }
        }
        let dispatchTime = DispatchTime.now() + .milliseconds(300)
        DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
        
            self.performSelector(onMainThread: #selector(self.goDetail), with: nil, waitUntilDone: false)
        })
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /// go map detail controller
        if segue.identifier == "showMapDetail" {
            NSLog("Current Reachbility: \(currentReachability)")
            
            //tell reachability since map detail includes viedeo
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
            
            let dest = (segue.destination as! MapDetailController)
            dest.currentMap = selectedMap!
        }
        
    }
    
    
    /// go map detail
    func goDetail(){
        self.performSegue(withIdentifier: "showMapDetail", sender: self)
    }
    
    
    /// initialize map infomation from plist
    static func initializeMaps()
    {
        let path = Bundle.main.path(forResource: "MapIntroData", ofType: "plist")
        let datas =  NSArray(contentsOfFile: path!)
        guard let data = datas
            else
        {
            return
        }
        for i in data
        {
            let proto = MapIntroInfo(loacation: (i as! [String:String])["location"]!, mapImage: UIImage.init(named: MapList.nameImageName[(i as! [String:String])["name"]!]!)!, flagImage: UIImage.init(named: MapList.country[(i as! [String:String])["name"]!]!)!, type: (i as! [String:String])["type"]!, terrain: (i as! [String:String])["terrain"]!, name: (i as! [String:String])["name"]!, description: (i as! [String:String])["description"]!, url: (i as! [String:String])["videoURL"]!)
            mapArray.append(proto)  
        }
    }
}
