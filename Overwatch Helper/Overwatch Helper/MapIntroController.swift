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
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.scrollView.delegate = self
        
        scrollView.contentSize = CGSize(width: 375, height: 750)
        for i in 0...6 {
            
            let width1 = i % 2 == 0 ? 275 : 200
            let width2 = 475 - width1
            let newMap1 = MapCell(frame: CGRect(x: -50, y: -50 + i*120, width: width1, height: 100), image: UIImage(named: mapNameList[2*i])!, label: mapNames[2*i], true)
            self.scrollView.addSubview(newMap1)
            
            let newMap2 = MapCell(frame: CGRect(x: width1 - 40, y: -50 + i*120, width: width2, height: 100), image: UIImage(named: mapNameList[2*i+1])!, label: mapNames[2*i+1], false)
            self.scrollView.addSubview(newMap2)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
