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
    var battleID: String
    var avatar: UIImage
    var descrip: String
    
    static var Messages: [LFGMessage] = []
    
    init(ID: String, avatar: UIImage, saying: String) {
        self.battleID = ID
        self.avatar = avatar
        self.descrip = saying
    }
}
