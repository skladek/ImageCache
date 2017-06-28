import SKImageCache
import SKWebServiceController
import UIKit

class FlickrController: WebServiceController {
    static let shared = FlickrController()

    init() {
        super.init(baseURL: kBASE_URL)

        ImageCache.shared.delegate = self
    }
}

extension FlickrController: ImageCacheDelegate {
    func loadImageAtURL(_ url: URL, completion: @escaping ImageCache.RemoteImageCompletion) -> URLSessionDataTask? {
        return getImage(url) { (image, response, error) in
            completion(image, error)
        }
    }
}
