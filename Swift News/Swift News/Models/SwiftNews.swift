//
//  SwiftNews.swift
//  Swift News
//
//  Created by Chenguo Yan on 2020-10-04.
//

import Foundation

struct SwiftNews: Decodable {
    let kind: String
    let data: NewsData
    
    struct NewsData: Decodable {
        let modhash: String
        let dist: Int
        let children: [Child]
        
        struct Child: Decodable {
            let kind: String
            let data: ChildData
        }
    }
}

struct ChildData: Codable {
    let title: String
    let url: String
    let thumbnail: String
    let thumbnailHeight: Int?
    let thumbnailWidth: Int?
    let selftext: String
    
    enum CodingKeys: String, CodingKey {
        case thumbnailHeight = "thumbnail_height"
        case thumbnailWidth = "thumbnail_width"
        case selftext
        case title
        case url
        case thumbnail
    }
}
