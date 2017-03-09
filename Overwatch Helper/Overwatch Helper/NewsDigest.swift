//
//  NewsDigest.swift
//  Overwatch Helper
//
//  Created by Benyan Gong on 3/5/17.
//  Copyright © 2017 Alex&Ben. All rights reserved.
//

import Foundation
struct NewsDigest {
    
}
class NewsData {
    var newsTitle:String
    var url:String
    var imageUrl:String
    init(title:String,url:String,imageUrl:String) {
        self.newsTitle = title
        self.url = url
        self.imageUrl = imageUrl
    }
}
