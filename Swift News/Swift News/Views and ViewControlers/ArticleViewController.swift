//
//  ArticleViewController.swift
//  Swift News
//
//  Created by Chenguo Yan on 2020-10-05.
//

import UIKit

class ArticleViewController: UIViewController {

    private enum Constants {
        static let selfThumbnail = "self"
    }
    var newsItem: ChildData? {
        didSet {
            guard let newsItem = newsItem else {
                return
            }
            articleBody.text = newsItem.selftext
            
            if let height = newsItem.thumbnailHeight, let width = newsItem.thumbnailWidth {
                imageWidth = width
                imageHeight = height
            }
            if newsItem.thumbnail != Constants.selfThumbnail {
                if let url = URL(string: newsItem.thumbnail) {
                    imageView.loadImage(from: url)
                }
            }
        }
    }

    private var imageHeight = 0
    private var imageWidth = 0
    private lazy var articleBody = UITextView()
    private lazy var imageView = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension ArticleViewController {
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = newsItem?.title
        
        view.addSubview(articleBody)
        view.addSubview(imageView)

        articleBody.isEditable = false
        articleBody.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeTopAnchor),
            imageView.widthAnchor.constraint(equalToConstant: CGFloat(imageWidth)),
            imageView.heightAnchor.constraint(equalToConstant: CGFloat(imageHeight)),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            articleBody.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            articleBody.bottomAnchor.constraint(equalTo: view.safeBottomAnchor),
            articleBody.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor),
            articleBody.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor)
        
        ])
    }
}
