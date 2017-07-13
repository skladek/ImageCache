import SKImageCache
import UIKit

class ImageViewModel: NSObject {

    let image: Image

    private var imageDownloadTask: URLSessionDataTask?

    init(image: Image) {
        self.image = image
    }

    func cancelImageDownload() {
        imageDownloadTask?.cancel()
    }

    func url() -> URL? {
        return image.imageURL()
    }

    func placeholderName() -> String {
        return "placeholderImage"
    }

    func title() -> String {
        return image.title
    }
}
