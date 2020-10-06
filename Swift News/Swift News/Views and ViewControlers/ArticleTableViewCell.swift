//
//  ArticleTableViewCell.swift
//  Swift News
//
//  Created by Chenguo Yan on 2020-10-05.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    let titleLabel = UILabel()
    let newsImageView = UIImageView()
    
    private enum Constants {
        static let selfUrl = "self"
    }
        
    func set(newsItem: ChildData) {
        titleLabel.text = newsItem.title
        let width = newsItem.thumbnailWidth ?? 0
        let height = newsItem.thumbnailHeight ?? 0
        if newsItem.url != Constants.selfUrl {
            if let url = URL(string: newsItem.url) {
                newsImageView.loadImage(from: url)
            }
        }
        setupCell(width: width, height: height)
    }
    
    private func setupCell(width: Int, height: Int) {
        contentView.addSubview(titleLabel)
        contentView.addSubview(newsImageView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            newsImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            newsImageView.widthAnchor.constraint(equalToConstant: CGFloat(width)),
            newsImageView.heightAnchor.constraint(equalToConstant: CGFloat(height)),
            newsImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
    }
}
