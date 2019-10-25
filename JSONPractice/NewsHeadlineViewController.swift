//
//  NewsHeadlineViewController.swift
//  JSONPractice
//
//  Created by Jehad Sarkar on 2019-10-25.
//  Copyright © 2019 itsjehad. All rights reserved.
//

import UIKit

class NewsHeadlineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView?
    
    var articleList: ArticleList?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleList?.articles.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "headLineCell", for: indexPath)
        let title = articleList?.articles[indexPath.row].title
        cell.textLabel?.text = title
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "headLineCell")
        retrieveNewArticles()

        // Do any additional setup after loading the view.
    }
    
    func retrieveNewArticles(){
        let session = URLSession.shared
        let queryParams = QueryParams("ca", "science")
        let httpClient = HTTPClient(session: session)
        httpClient.sendRequest("https://newsapi.org/v2/top-headlines", parameters: queryParams.getQueryParamsDict(), completion: { [weak self] (articleList, response) in
            self?.articleList = articleList
            DispatchQueue.main.async {
                self?.tableView?.reloadData()
            }
        })
    }
}
