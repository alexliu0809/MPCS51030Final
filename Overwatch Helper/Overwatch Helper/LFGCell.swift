//
//  LFGCell.swift
//  Overwatch Helper
//
//  Created by Benyan Gong on 3/10/17.
//  Copyright © 2017 Alex&Ben. All rights reserved.
//

import UIKit

class LFGCell: UITableViewCell {

    var avatar: UIImageView
    var battleID: UILabel
    var descrip: UITextView
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        
        avatar = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        
        battleID = UILabel(frame: CGRect(x: 110, y: 0, width: 100, height: 30))
        
        descrip = UITextView(frame: CGRect(x: 110, y: 50, width: 255, height: 200))
        

        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.contentView.addSubview(avatar)
        self.contentView.addSubview(battleID)
        self.contentView.addSubview(descrip)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
