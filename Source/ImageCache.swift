import Foundation
import UIKit

/// An object to handle caching of images using their remote URL as the key for retrieval.
public class ImageCache {

    // MARK: Class Types

    // TODO: Change the bool to an image source enum
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

    /// Provides an option to utilize local storage for files. If set to true, the images will be saved to the documents directory
    /// in addition to being available in the cache. If false, files will only be added to the cache.
    public var useLocalStorage: Bool = false

    // MARK: Internal Variables

    let cache: NSCache<AnyObject, UIImage>

    let localFileController: LocalFileController

    // MARK: Init Methods

    init() {
        self.cache = NSCache<AnyObject, UIImage>()
        self.localFileController = LocalFileController()
    }

    init(cache: NSCache<AnyObject, UIImage>, localFileController: LocalFileController) {
        self.cache = cache
        self.localFileController = localFileController
    }

    // MARK: Public Methods

    // TODO: Update Docs
    /// Adds the provided image to the cache using the url as the key.
    ///
    /// - Parameters:
    ///   - image: The image to cache.
    ///   - url: The image's remote path.
    public func cacheImage(_ image: UIImage?, forURL url: URL, directory: String? = nil) {
        guard let image = image else {
            return
        }

        if useLocalStorage == true,
            let imageName = imageNameFromURL(url) as? String {
            localFileController.saveImage(image, fileName: imageName, directory: directory)
        }

        let imageName = imageNameFromURL(url)
        cache.setObject(image, forKey: imageName)
    }

    /// Removes all objects from the cache.
    public func emptyCache() {
        cache.removeAllObjects()
    }

    // TODO: Update Docs
    /// Retrieves an images from the provided URL. This could be from the cache or from the remote source.
    ///
    /// - Parameters:
    ///   - url: The URL for the image.
    ///   - skipCache: If true, the cached is not checked first, the image is retrieved from the remote source and added to the cache.
    ///   - completion: The image, a boolean indicating true if the image was retrieved from the cache, and an error.
    /// - Returns: An optional data task if the image is retrieved from the remote source.
    public func getImage(url: URL, directory: String? = nil, skipCache: Bool = false, completion: @escaping ImageCompletion) -> URLSessionDataTask? {
        if let image = retrieveFromCache(url: url), skipCache == false {
            completion(image, true, nil)
            return nil
        }

        if useLocalStorage == true {
            if let fileName = imageNameFromURL(url) as? String {
                if let image = localFileController.getImage(imageName: fileName, directory: directory) {
                    completion(image, false, nil)
                }
            }
        }

        return delegate?.loadImageAtURL(url, completion: { [weak self] (image, error) in
            self?.cacheImage(image, forURL: url, directory: directory)
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
