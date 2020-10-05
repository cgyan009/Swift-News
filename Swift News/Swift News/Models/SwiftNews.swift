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
            
            struct ChildData: Decodable {
                let title: String
                let url: String
                let thumbnail: String
                let thumbnailHeight: Int?
                let thumbnailWidth: Int?
            }
        }
    }
}
