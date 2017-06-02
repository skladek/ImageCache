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

        let nib = UINib(nibName: "ImageCell", bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: cellReuseId)

        dataSource = TableViewDataSource<Image>(objects: [Image](), cellReuseId: cellReuseId, cellPresenter: { (cell, object) in
            guard let cell = cell as? ImageCell else {
                return
            }

            let viewModel = ImageViewModel(image: object)
            cell.setViewModel(viewModel)
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
            let indexPath = IndexPath(row: 0, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .none, animated: false)
        }
    }
}
