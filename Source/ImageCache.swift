import Foundation
import UIKit

/// An object to handle caching of images using their remote URL as the key for retrieval.
public class ImageCache {

    // MARK: Class Types

    /// A closure providing an optional image, boolean indicating true if the image was retrieved from the cache, and error.
    public typealias ImageCompletion = (UIImage?, Bool, Error?) -> Void

    /// A closure to be returned by a remote source providing an optional image and error.
    public typealias RemoteImageCompletion = (UIImage?, Error?) -> Void

    // MARK: Class Variables

    /// A singleton instance of the cache.
    public static let shared = ImageCache()

    // MARK: Public Variables

    /// The object responding to delegate events.
    public weak var delegate: ImageCacheDelegate?

    // MARK: Internal Variables

    let cache: NSCache<AnyObject, UIImage>

    // MARK: Init Methods

    init() {
        self.cache = NSCache<AnyObject, UIImage>()
    }

    init(cache: NSCache<AnyObject, UIImage>) {
        self.cache = cache
    }

    // MARK: Public Methods

    /// Adds the provided image to the cache using the url as the key.
    ///
    /// - Parameters:
    ///   - image: The image to cache.
    ///   - url: The image's remote path.
    public func cacheImage(_ image: UIImage?, forURL url: URL) {
        guard let image = image else {
            return
        }

        let imageName = imageNameFromURL(url)
        cache.setObject(image, forKey: imageName)
    }

    /// Removes all objects from the cache.
    public func emptyCache() {
        cache.removeAllObjects()
    }

    /// Retrieves an images from the provided URL. This could be from the cache or from the remote source.
    ///
    /// - Parameters:
    ///   - url: The URL for the image.
    ///   - skipCache: If true, the cached is not checked first, the image is retrieved from the remote source and added to the cache.
    ///   - completion: The image, a boolean indicating true if the image was retrieved from the cache, and an error.
    /// - Returns: An optional data task if the image is retrieved from the remote source.
    public func getImage(url: URL, skipCache: Bool = false, completion: @escaping ImageCompletion) -> URLSessionDataTask? {
        if let image = retrieveFromCache(url: url), skipCache == false {
            completion(image, true, nil)
            return nil
        }

        return delegate?.loadImageAtURL(url, completion: { [weak self] (image, error) in
            self?.cacheImage(image, forURL: url)
            completion(image, false, error)
        })
    }

    /// Removes the object cached with the provided URL.
    ///
    /// - Parameter url: The URL of the image to remove.
    public func removeObjectAtURL(_ url: URL) {
        let imageName = imageNameFromURL(url)
        cache.removeObject(forKey: imageName)
    }

    // MARK: Private Methods

    private func imageNameFromURL(_ url: URL) -> AnyObject {
        return url.lastPathComponent as AnyObject
    }

    private func retrieveFromCache(url: URL) -> UIImage? {
        let imageName = imageNameFromURL(url)
        return cache.object(forKey: imageName)
    }
}
