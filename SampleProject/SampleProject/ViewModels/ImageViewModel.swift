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

    func image(completion: @escaping ImageCache.ImageCompletion) {
        guard let url = image.imageURL() else {
            return
        }

        imageDownloadTask = ImageCache.shared.getImage(url: url, completion: completion)
    }

    func title() -> String {
        return image.title
    }
}
