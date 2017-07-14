import Foundation
import UIKit

@testable import SKImageCache

class MockImageHandler: ImageHandling {
    var disolveToImageCalled = false
    var imageWithURLCalled = false
    var placeholderImageCalled = false
    var setImageCalled = false

    func dissolveToImage(_ image: UIImage, onView view: UIImageView) {
        disolveToImageCalled = true
    }

    func image(_ url: URL?, imageCache: ImageCache, directory: String?, skipCache: Bool, completion: @escaping ImageCache.ImageCompletion) -> URLSessionDataTask? {
        imageWithURLCalled = true
        completion(nil, .remote, nil)

        return nil
    }

    func placeholderImage(_ imageName: String?, bundle: Bundle?) -> UIImage? {
        placeholderImageCalled = true

        return nil
    }

    func setImage(_ image: UIImage, onView view: UIImageView) {
        setImageCalled = true
    }
}
