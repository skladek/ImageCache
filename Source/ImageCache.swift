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

    /// Provides an option to utilize the path provided in the url for file storage. If this is set to yes, any folder structure specified
    /// in the URL past the base URL will be appended onto any provided directory settings. This is useful in situations where the file
    /// names are not guaranteed to be unique, but the URLs leading to them are.
    public var useURLPathing: Bool = false

    // MARK: Internal Types

    typealias ImageInfo = (imageKey: AnyObject, imageName: AnyObject, path: AnyObject?)

    // MARK: Internal Variables

    let cache: NSCache<AnyObject, UIImage>
    let localImageController: LocalImageControllerProtocol

    // MARK: Init Methods

    init() {
        self.cache = NSCache<AnyObject, UIImage>()
        self.localImageController = LocalImageController()
    }

    init(cache: NSCache<AnyObject, UIImage>, localFileController: LocalImageControllerProtocol) {
        self.cache = cache
        self.localImageController = localFileController
    }

    // MARK: Public Methods

    /// Adds the provided image to the cache using the url as the key.
    ///
    /// - Parameters:
    ///   - image: The image to cache
    ///   - url: The image's remote path
    ///   - directory: The directory to save the image in if useLocalStorage is set to true.
    public func cacheImage(_ image: UIImage?, forURL url: URL, directory: String? = nil) {
        let imageInfo = imageInfoFromURL(url)

        guard let image = image,
            let imageKey = imageInfo.imageKey as? String,
            let imageName = imageInfo.imageName as? String else {
            return
        }

        if useLocalStorage == true {
            let appendedDirectory = concatImageInfoAndDirectory(imageInfo: imageInfo, directory: directory)
            localImageController.savePNG(image, fileName: imageName, directory: appendedDirectory)
        }

        cache.setObject(image, forKey: imageKey as AnyObject)
    }

    /// Deletes the folder at the provided path.
    ///
    /// - Parameter directory: The directory to be deleted.
    public func deleteDirectory(_ directory: String) {
        localImageController.deleteDirectory(directory)
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
        if let image = retrieveFromCache(url: url),
            skipCache == false {
            completion(image, .cache, nil)
            return nil
        }

        let imageInfo = imageInfoFromURL(url)
        let concatenatedDirectory = concatImageInfoAndDirectory(imageInfo: imageInfo, directory: directory)

        if useLocalStorage == true,
            skipCache == false,
            let fileName = imageInfo.imageKey as? String,
            let image = localImageController.getImage(imageName: fileName, directory: concatenatedDirectory) {
            completion(image, .localStorage, nil)
            return nil
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
        let imageInfo = imageInfoFromURL(url)
        let imageKey = imageInfo.imageKey
        cache.removeObject(forKey: imageKey)
    }

    // MARK: Instance Methods

    func concatImageInfoAndDirectory(imageInfo: ImageInfo, directory: String?) -> String {
        return "\(directory ?? "")\(imageInfo.path as? String ?? "")"
    }

    func imageInfoFromURL(_ url: URL) -> ImageInfo {
        if useURLPathing == true {
            let urlPath = url.path
            let lastPathComponent = url.lastPathComponent
            let adjustedURLPath = urlPath.replacingOccurrences(of: lastPathComponent, with: "")

            return (imageKey: urlPath as AnyObject, imageName: lastPathComponent as AnyObject, path: adjustedURLPath as AnyObject)
        }

        return (imageKey: url.lastPathComponent as AnyObject, imageName: url.lastPathComponent as AnyObject, path: nil)
    }

    // MARK: Private Methods

    private func retrieveFromCache(url: URL) -> UIImage? {
        let imageInfo = imageInfoFromURL(url)
        return cache.object(forKey: imageInfo.imageKey)
    }
}
