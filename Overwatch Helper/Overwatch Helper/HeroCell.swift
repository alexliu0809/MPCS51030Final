//
//  HeroCell.swift
//  Overwatch Helper
//
//  Created by Enze on 3/6/17.
//  Copyright © 2017 Alex&Ben. All rights reserved.
//

import UIKit
import FoldingCell

class HeroCell: FoldingCell {

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        foregroundView.layer.cornerRadius = 10
        foregroundView.layer.masksToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func animationDuration(_ itemIndex:NSInteger, type:AnimationType)-> TimeInterval {
        
        // durations count equal it itemCount
        let durations = [0.33, 0.26, 0.26] // timing animation for each view
        return durations[itemIndex]
    }

    
}
