//
//  LFGMessage.swift
//  Overwatch Helper
//
//  Created by Benyan Gong on 3/10/17.
//  Copyright © 2017 Alex&Ben. All rights reserved.
//

import Foundation
import UIKit

struct LFGMessage {
    
    /// User s BattleNet ID
    var battleID: String
    
    /// User's avatar
    var avatar: UIImage
    
    /// message content
    var descrip: String
    
    
    /// message list
    static var Messages: [LFGMessage] = []
    
    
    /// - Parameters:
    ///   - ID
    ///   - avatar
    ///   - saying
    init(ID: String, avatar: UIImage, saying: String) {
        self.battleID = ID
        self.avatar = avatar
        self.descrip = saying
    }
}
