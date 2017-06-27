import Foundation

@testable import SKImageCache

class MockImageCache: ImageCache {
    var getImageCalled = false

    override func getImage(url: URL, skipCache: Bool, completion: @escaping ImageCache.ImageCompletion) -> URLSessionDataTask? {
        getImageCalled = true

        return URLSessionDataTask()
    }
}
