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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(newsItem: ChildData) {
        titleLabel.text = newsItem.title
        let width = newsItem.thumbnailWidth ?? 0
        let height = newsItem.thumbnailHeight ?? 0
        if newsItem.url != "self" {
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
            newsImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            newsImageView.widthAnchor.constraint(equalToConstant: CGFloat(width)),
            newsImageView.heightAnchor.constraint(equalToConstant: CGFloat(height)),
            newsImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            newsImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

}
