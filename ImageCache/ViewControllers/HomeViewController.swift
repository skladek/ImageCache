//
//  HomeViewController.swift
//  ImageCache
//
//  Created by Sean on 5/31/17.
//  Copyright © 2017 Sean Kladek. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    let imagesController = ImagesController()

    @IBOutlet weak var tableView: UITableView!

    var dataSource: TableViewDataSource<Image>? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        let cellReuseId = "HomeViewControllerCellReuseId"

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseId)

        dataSource = TableViewDataSource<Image>(objects: [Image](), cellReuseId: cellReuseId, cellPresenter: { (cell, object) in
            cell.textLabel?.text = object.title
        })

        tableView.dataSource = dataSource
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()

        imagesController.searchImagesFor(searchBar.text) { (images, error) in
            self.dataSource?.objects(images)
            self.tableView.reloadData()
        }
    }
}
