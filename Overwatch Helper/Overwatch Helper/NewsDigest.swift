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

/// All the info for a news
class NewsData {
    /// title
    var newsTitle:String
    
    /// News url
    var url:String
    
    
    /// News Image
    var imageUrl:String
    
    
    /// Init a news
    ///
    /// - Parameters:
    ///   - title: title
    ///   - url: url
    ///   - imageUrl: news image url
    init(title:String,url:String,imageUrl:String) {
        self.newsTitle = title
        self.url = url
        self.imageUrl = imageUrl
    }
}
