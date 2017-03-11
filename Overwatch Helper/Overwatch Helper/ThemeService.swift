//
//  ThemeService.swift
//  Overwatch Helper
//
//  Created by 刘 恩泽 on 3/8/17.
//  Copyright © 2017 Alex&Ben. All rights reserved.
//

import Foundation
import UIKit

class ThemeManager{
    static let Shared = ThemeManager()
    
    func setNavigationBar(bgColor:UIColor,tintColor:UIColor,titleColor:UIColor)
    {
        UINavigationBar.appearance().barTintColor = bgColor //back ground color
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : titleColor] //title color
        UINavigationBar.appearance().tintColor = tintColor //set font color of edit/+/detail
    }
    
    func setToolBar(bgColor:UIColor, tintColor:UIColor)
    {
        UITabBar.appearance().barTintColor = bgColor
        UITabBar.appearance().tintColor = tintColor
    }

}


