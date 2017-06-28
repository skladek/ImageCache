import UIKit

class ImageCell: UITableViewCell {

    @IBOutlet weak var cellImage: UIImageView!

    @IBOutlet weak var title: UILabel!

    private var imageDataTask: URLSessionDataTask?

    private var viewModel: ImageViewModel?

    func setViewModel(_ viewModel: ImageViewModel) {
        self.viewModel = viewModel

        imageDataTask = cellImage.setImageFromURL(viewModel.url(), placeholderImageName: viewModel.placeholderName())

        title.text = viewModel.title()
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        imageDataTask?.cancel()
    }
}
