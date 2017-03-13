//
//  MapIntroController.swift
//  Overwatch Helper
//
//  Created by Benyan Gong on 3/5/17.
//  Copyright © 2017 Alex&Ben. All rights reserved.
//

import Foundation
import UIKit

var mapArray: [MapIntroInfo] = []

class MapIntroController: UIViewController{
    
    @IBOutlet weak var scrollView: UIScrollView!
    var mapList : [MapCell] = []
    var mapNameList : [String] = ["map_volskayaindustry","map_nepal","map_antarctica","map_dorado","map_templeofanubis","map_oasis","map_numbani","map_route66","map_gibraltar","map_hanamura","map_hollywood","map_eichenwalde","map_lijiangtower","map_Ilios"]
    var mapNames : [String] = ["VOLSKAYA INDUSTRY","NEPAL","ANTARCTICA","DORADO","TEMPLE OF ANUBIS","OASIS","NUMBANI","ROUTE 66","GIBRALTAR","HANAMURA","HOLLYWOOD","EICHENWALDE","LIJIANG TOWER","ILIOS"]
    var gestures : [UITapGestureRecognizer] = []
    var selectedMap : MapIntroInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "discover-bg"))
        scrollView.contentSize = CGSize(width: 375, height: 750)
        for i in 0...6 {
            
            let width1 = i % 2 == 0 ? 275 : 200
            let width2 = 475 - width1
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
    
    override func viewWillAppear(_ animated: Bool) {
        for i in 0...13 {
            if i % 2 == 0 {
                UIView.animate(withDuration: 0.7, animations: {
                    self.mapList[i].center.x = -50 + self.mapList[i].frame.width / 2
                })
            }else{
                UIView.animate(withDuration: 0.7, animations: {
                    self.mapList[i].center.x = 435 - self.mapList[i].frame.width / 2
                })
            }
        }
    }
    
    func handleTap(_ recognizer : UITapGestureRecognizer){
        
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
        var dispatchTime = DispatchTime.now() + .milliseconds(300)
        DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
        
            self.performSelector(onMainThread: #selector(self.goDetail), with: nil, waitUntilDone: false)
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMapDetail" {
            if currentReachability != .reachableViaWiFi {
            
            let alert = UIAlertController(title: "Connection Failed", message: "Oops...Something wrong", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK", style: .default, handler: {
                action in
            })
            alert.addAction(action)
            }
            let dest = (segue.destination as! MapDetailCßontroller)
            dest.currentMap = selectedMap!
            
            

//            let segueAnimationView = segue.destination.view as UIView
//            
//            segueAnimationView.frame = CGRect(x: 0, y: 0, width: 375, height: 667)
//            segueAnimationView.backgroundColor = UIColor(red: 54, green: 54, blue: 54, alpha: 1)
////            segueAnimationView.alpha = 0
//            
//            let window = UIApplication.shared.keyWindow

//            window?.insertSubview(segueAnimationView, aboveSubview: self.view)
//            UIView.animate(withDuration: 1, animations: {
//                segueAnimationView.alpha = 1
//            }, completion: {
//                finish in
//            })

            
        }
        
    }
    
    func goDetail(){
        self.performSegue(withIdentifier: "showMapDetail", sender: self)
    }
    
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
            
            //print(proto.heroName)
            
            mapArray.append(proto)  
        }
    }
}
