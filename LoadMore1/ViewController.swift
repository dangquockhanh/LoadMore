//
//  ViewController.swift
//  LoadMore1
//
//  Created by Đặng Khánh  on 4/30/19.
//  Copyright © 2019 Khánh Trắng. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var list = [Int]()
    var pageNumber = 0
    var pageTotal = 3 // số lân load data
    var pageSize = 10 // số lần hiển thị nội dung in page
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMore()
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        // Do any additional setup after loading the view.
    }
    @objc func refreshData() {
        list = [Int](0...10)
        tableView.reloadData()
        refreshControl?.endRefreshing() // load lại data
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = String(list[indexPath.row])
        return cell
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == list.count - 1 {
            guard pageNumber < pageTotal else {return} // điều kiện
            loadMore()
        }
    }
    func loadMore() {
        guard pageNumber < pageTotal else {return}
        
        let lastRequest = pageNumber == pageTotal - 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.list += [Int](0..<self.pageSize)
            self.tableView.reloadData()
            self.pageNumber += 1
        if lastRequest {
            self.indicator.stopAnimating() // vòng tròn hiển thị load data
        }
    }
}


}
