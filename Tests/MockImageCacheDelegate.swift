import Foundation
import UIKit

@testable import SKImageCache

class MockImageCacheDelegate: ImageCacheDelegate {
    var loadImageAtURLCalled = false

    func loadImageAtURL(_ url: URL, completion: @escaping ImageCache.RemoteImageCompletion) -> URLSessionDataTask? {
        loadImageAtURLCalled = true

        let bundle = Bundle(for: type(of: self))
        let image = UIImage(named: "testimage", in: bundle, compatibleWith: nil)

        completion(image, nil)

        return nil
    }
}
