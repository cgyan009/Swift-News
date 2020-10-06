//
//  MainViewController.swift
//  Swift News
//
//  Created by Chenguo Yan on 2020-10-04.
//

import UIKit

class MainViewController: UIViewController {
    
    private enum Constants {
        static let cellId = "newsCell"
        static let title = "Swift News"
        static let loading = "Loading Data ..."
        static let cellHeightOffset = 36
    }
    
    private lazy var viewModel = NewsViewModel()
    private lazy var newsTable = UITableView(frame: .zero, style: .plain)
    private lazy var loadingDataUI: UILabel = {
        let label = UILabel()
        label.text = Constants.loading
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = Constants.title
        setupPromptionLabel()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(listen(notification:)),
                                               name: .newsNotofication,
                                               object: nil)
        
        viewModel.getNews()
    }
    
    @objc private func listen(notification: Notification) {
        DispatchQueue.main.async { [weak self] in
            if !(notification.object is Error) {
                self?.setupNewsTableUI()
                self?.newsTable.reloadData()
            }
            
        }
    }
}

extension MainViewController {
    
    private func setupNewsTableUI() {
     
        loadingDataUI.removeFromSuperview()
        newsTable.delegate = self
        newsTable.dataSource = self
        newsTable.register(ArticleTableViewCell.self, forCellReuseIdentifier: Constants.cellId)
        view.addSubview(newsTable)
        newsTable.estimatedRowHeight = UITableView.automaticDimension
        

        newsTable.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            newsTable.topAnchor.constraint(equalTo: view.safeTopAnchor),
            newsTable.bottomAnchor.constraint(equalTo: view.safeBottomAnchor),
            newsTable.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor),
            newsTable.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor)
        ])
    }
    
    private func setupPromptionLabel() {
        view.addSubview(loadingDataUI)
        loadingDataUI.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingDataUI.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingDataUI.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfNews
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ArticleTableViewCell = tableView.dequeueReusableCell(withIdentifier: Constants.cellId, for: indexPath) as! ArticleTableViewCell
        if let newsItem = viewModel.swiftNews?.data.children[indexPath.row].data {
            cell.set(newsItem: newsItem)
            return cell
        } else {
            return UITableViewCell()
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = viewModel.swiftNews?.data.children[indexPath.row].data
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        if let navigationController = window?.rootViewController as? UINavigationController {
            let articleViewController = ArticleViewController()
            articleViewController.newsItem = item
            
            navigationController.pushViewController(articleViewController, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = viewModel.swiftNews?.data.children[indexPath.row].data.thumbnailHeight ?? 0
        return CGFloat(height + Constants.cellHeightOffset);
    }
}
