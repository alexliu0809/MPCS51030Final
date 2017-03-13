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
        
        battleID = UILabel(frame: CGRect(x: 110, y: 0, width: 265, height: 30))
        
        descrip = UITextView(frame: CGRect(x: 110, y: 30, width: 255, height: 100))
        
        
        battleID.font = UIFont(name: "Verdana-BoldItalic", size: 27)
        battleID.textColor = UIColor.white
        descrip.font = UIFont(name: "Verdana", size: 17)
        descrip.textColor = UIColor.white
        descrip.backgroundColor = UIColor.green//UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)

        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.contentView.addSubview(avatar)
        self.contentView.addSubview(battleID)
        self.contentView.addSubview(descrip)
        self.isUserInteractionEnabled = false
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
