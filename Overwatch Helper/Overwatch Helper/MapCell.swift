//
//  MapCell.swift
//  Overwatch Helper
//
//  Created by Benyan Gong on 3/8/17.
//  Copyright © 2017 Alex&Ben. All rights reserved.
//

import UIKit


/// <#Description#>
class MapCell: UIView {

    /// <#Description#>
    var img: UIImageView
    
    /// <#Description#>
    var lbl: UILabel
    
    /// <#Description#>
    var name: String
    
    /// <#Description#>
    var number: Int
    
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - frame: <#frame description#>
    ///   - map: <#map description#>
    ///   - left: <#left description#>
    ///   - num: <#num description#>
    init(frame: CGRect, _ map: MapIntroInfo,_ left: Bool, _ num: Int) {
        self.name = map.name
        img = UIImageView(frame: CGRect(x: left ? 50 : 0, y: 0, width: frame.width - 50, height: frame.height))
        img.image = map.topImage
        
        lbl = UILabel(frame: CGRect(x: left ? 50 : 0, y: 30, width: frame.width - 50, height: 50))
        lbl.textColor = UIColor.white
        lbl.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        lbl.font = UIFont(name: "Verdana-BoldItalic", size: 15)
        lbl.text = map.name
        lbl.textAlignment = .center
        self.number = num
        
        super.init(frame: frame)
        
        self.addSubview(img)
        self.addSubview(lbl)
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
