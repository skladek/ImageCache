import Foundation
import UIKit

/// An object to handle caching of images using their remote URL as the key for retrieval.
public class ImageCache {

    // MARK: Class Types

    /// Defines the source of the image.
    public enum ImageSource {
        /// The image was retrieved from the cache.
        case cache
        /// The image was retrieved from disk.
        case localStorage
        /// The image was retrieved from the remote source.
        case remote
    }

    /// A closure providing an optional image, image source, and error.
    public typealias ImageCompletion = (UIImage?, ImageSource, Error?) -> Void

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

    let localFileController: LocalFileControllerProtocol

    // MARK: Init Methods

    init() {
        self.cache = NSCache<AnyObject, UIImage>()
        self.localFileController = LocalFileController()
    }

    init(cache: NSCache<AnyObject, UIImage>, localFileController: LocalFileControllerProtocol) {
        self.cache = cache
        self.localFileController = localFileController
    }

    // MARK: Public Methods

    /// Adds the provided image to the cache using the url as the key.
    ///
    /// - Parameters:
    ///   - image: The image to cache
    ///   - url: The image's remote path
    ///   - directory: The directory to save the image in if useLocalStorage is set to true.
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

    /// Retrieves an image from the provided URL. This could be from the cache or from the remote source.
    ///
    /// - Parameters:
    ///   - url: The URL for the image.
    ///   - directory: The directory of the image if useLocalStorage is set to true. This path will be appended to the documents directory path.
    ///   - skipCache: If true, the cache is not checked first, the image is retrieved from the remote source and added to the cache.
    ///   - completion: The image, a boolean indicating true if the image was retrieved from the cache, and an error.
    /// - Returns: An optional data task if the image is retrieved from the remote source.
    public func getImage(url: URL, directory: String? = nil, skipCache: Bool = false, completion: @escaping ImageCompletion) -> URLSessionDataTask? {
        if let image = retrieveFromCache(url: url), skipCache == false {
            completion(image, .cache, nil)
            return nil
        }

        if useLocalStorage == true {
            if let fileName = imageNameFromURL(url) as? String {
                if let image = localFileController.getImage(imageName: fileName, directory: directory) {
                    completion(image, .localStorage, nil)
                }
            }
        }

        return delegate?.loadImageAtURL(url, completion: { [weak self] (image, error) in
            self?.cacheImage(image, forURL: url, directory: directory)
            completion(image, .remote, error)
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
