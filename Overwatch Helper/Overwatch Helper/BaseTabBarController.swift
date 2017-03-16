//
//  BaseTabBarController.swift
//  Overwatch Helper
//
//  Created by Enze on 3/6/17.
//  Copyright © 2017 Alex&Ben. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    /// Default Screen Index
    @IBInspectable var defaultIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedIndex = defaultIndex
    
        setupMiddleButton()
        
        //Set Themes
        ThemeManager.Shared.setNavigationBar(bgColor: UIColor.black, tintColor: UIColor(hexString: "F89E19"), titleColor: UIColor(hexString: "F89E19"))
        ThemeManager.Shared.setToolBar(bgColor: UIColor.black, tintColor: UIColor.white)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
    
    // MARK: - Setups
    /// Set up the customized button that appears in the middle (mcree).
    func setupMiddleButton() {
        NSLog("Special Middle Button Clicked")
        
        let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 75, height: 75))
        
        //Create a button
        var menuButtonFrame = menuButton.frame
        menuButtonFrame.origin.y = view.bounds.height - menuButtonFrame.height
        menuButtonFrame.origin.x = view.bounds.width/2 - menuButtonFrame.size.width/2
        menuButton.frame = menuButtonFrame
        
        //menuButton.imageView?.image = UIImage(named: "Main-Icon")
        //menuButton.imageView?.contentMode = .scaleToFill
        //menuButton.backgroundColor = UIColor.red
        menuButton.layer.cornerRadius = menuButtonFrame.height/2
        view.addSubview(menuButton) //add the button
        
        menuButton.setImage(UIImage(named: "Main-Icon-New"), for: .normal) //set image
        menuButton.addTarget(self, action: #selector(menuButtonAction(sender:)), for: .touchUpInside)//add click function
        
        view.layoutIfNeeded()
    }
    
    
    /// Click on the customized button returns to index 2.
    ///
    /// - Parameter sender: The Middle Button
    @objc private func menuButtonAction(sender: UIButton) {
        NSLog("Change Selected Button to 2")
        
        selectedIndex = 2
    }
    

}
