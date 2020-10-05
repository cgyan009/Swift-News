//
//  NewsViewModel.swift
//  Swift News
//
//  Created by Chenguo Yan on 2020-10-04.
//

import Foundation

class NewsViewModel {
    private let api = API.shared
    var swiftNews: SwiftNews? {
        didSet {
            NotificationCenter.default.post(name: .newsNotofication, object: nil)
        }
    }
    
    var numberOfNews: Int {
        if let swiftNews = swiftNews {
            return swiftNews.data.children.count
        } else {
            return 0
        }
    }
    
    func getNews() {
        api.fetchData {[weak self] (result: Result<SwiftNews, Error>) in
            switch result {
            case .success(let news):
                self?.swiftNews = news
            case .failure(let error):
                NotificationCenter.default.post(name: .newsNotofication, object: error)
                print(error.localizedDescription)
            }
        }
    }
}
