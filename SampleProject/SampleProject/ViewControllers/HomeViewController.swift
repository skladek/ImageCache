import SKImageCache
import SKTableViewDataSource
import UIKit

class HomeViewController: UIViewController {

    let imagesController = ImagesController()

    @IBOutlet weak var tableView: UITableView!

    var dataSource: TableViewDataSource<Image>? = nil

    func deleteLocalStorageTapped() {
        ImageCache.shared.deleteDirectory("12345/")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let cellNib = UINib(nibName: "ImageCell", bundle: Bundle.main)

        dataSource = TableViewDataSource(objects: [Image](), cell: cellNib, cellPresenter: { (cell, object) in
            guard let cell = cell as? ImageCell else {
                return
            }

            let viewModel = ImageViewModel(image: object)
            cell.setViewModel(viewModel)
        })

        tableView.dataSource = dataSource

        let deleteButton = UIBarButtonItem(title: "Delete Local Storage", style: .done, target: self, action: #selector(deleteLocalStorageTapped))
        navigationItem.rightBarButtonItem = deleteButton
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()

        imagesController.searchImagesFor(searchBar.text) { (images, error) in
            self.dataSource?.setObjects(images)
            self.tableView.reloadData()
            let indexPath = IndexPath(row: 0, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .none, animated: false)
        }
    }
}
