//
//  MapIntroController.swift
//  Overwatch Helper
//
//  Created by Benyan Gong on 3/5/17.
//  Copyright © 2017 Alex&Ben. All rights reserved.
//

import Foundation
import UIKit

class MapIntroController: UIViewController{
    
    @IBOutlet weak var scrollView: UIScrollView!
    var mapList : [MapCell] = []
    var mapNameList : [String] = ["map_volskayaindustry","map_nepal","map_antarctica","map_dorado","map_templeofanubis","map_oasis","map_numbani","map_route66","map_gibraltar","map_hanamura","map_hollywood","map_eichenwalde","map_lijiangtower","map_Ilios"]
    var mapNames : [String] = ["VOLSKAYA INDUSTRY","NEPAL","ANTARCTICA","DORADO","TEMPLE OF ANUBIS","OASIS","NUMBANI","ROUTE 66","GIBRALTAR","HANAMURA","HOLLYWOOD","EICHENWALDE","LIJIANG TOWER","ILIOS"]
    var gestures : [UITapGestureRecognizer] = []
    var seletedMap : String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: 375, height: 750)
        for i in 0...6 {
            
            let width1 = i % 2 == 0 ? 275 : 200
            let width2 = 475 - width1
            let newMap1 = MapCell(frame: CGRect(x: -50, y: -50 + i*120, width: width1, height: 100), image: UIImage(named: mapNameList[2*i])!, label: mapNames[2*i], true)
            
            let ges1 = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            newMap1.addGestureRecognizer(ges1)
            
            self.mapList.append(newMap1)
            self.scrollView.addSubview(newMap1)
            
            
            let newMap2 = MapCell(frame: CGRect(x: width1 - 40, y: -50 + i*120, width: width2, height: 100), image: UIImage(named: mapNameList[2*i+1])!, label: mapNames[2*i+1], false)
            
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
            seletedMap = selectedCell.name
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
            let dest = (segue.destination as! MapDetailController)
            dest.currentMapName = seletedMap!
            
            

            let segueAnimationView = segue.destination.view as UIView
            
            segueAnimationView.frame = CGRect(x: 0, y: 0, width: 375, height: 667)
            segueAnimationView.alpha = 0
            
            let window = UIApplication.shared.keyWindow

            window?.insertSubview(segueAnimationView, aboveSubview: self.view)
            UIView.animate(withDuration: 1, animations: {
                segueAnimationView.alpha = 1
            }, completion: {
                finish in
            })

            
        }
        
    }
    
    func goDetail(){
        self.performSegue(withIdentifier: "showMapDetail", sender: self)
    }
}
