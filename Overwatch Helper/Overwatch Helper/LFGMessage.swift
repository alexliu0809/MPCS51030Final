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
    
    /// <#Description#>
    var battleID: String
    
    /// <#Description#>
    var avatar: UIImage
    
    /// <#Description#>
    var descrip: String
    
    
    /// <#Description#>
    static var Messages: [LFGMessage] = []
    
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - ID: <#ID description#>
    ///   - avatar: <#avatar description#>
    ///   - saying: <#saying description#>
    init(ID: String, avatar: UIImage, saying: String) {
        self.battleID = ID
        self.avatar = avatar
        self.descrip = saying
    }
}
