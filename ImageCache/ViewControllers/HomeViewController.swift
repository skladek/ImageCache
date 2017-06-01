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

    let stringArray = ["Row", "Row", "Row", "Row", "Row", "Row", "Row", "Row", "Row", "Row", "Row", "Row"]

    @IBOutlet weak var tableView: UITableView!

    var dataSource: TableViewDataSource<String>? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        let cellReuseId = "HomeViewControllerCellReuseId"

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseId)

        dataSource = TableViewDataSource<String>(objects: stringArray, cellReuseId: cellReuseId, cellPresenter: { (cell, object) in
            cell.textLabel?.text = object
        })

        tableView.dataSource = dataSource
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()

        imagesController.searchImagesFor(searchBar.text ?? "")
    }
}
