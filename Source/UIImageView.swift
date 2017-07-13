import UIKit

public extension UIImageView {

    // MARK: Internal Types

    struct Image {
        let placeholderImageName: String?
        let url: URL?
    }

    struct CacheConfig {
        let directory: String?
        let imageCache: ImageCache
        let imageHandler: ImageHandling
        let skipCache: Bool
    }

    // MARK: Public Methods

    /// Sets the image on the image view to the placeholder image and then later to an image from the cache
    /// or remote source once it has been retrieved.
    ///
    /// - Parameters:
    ///   - url: The URL of the final image.
    ///   - placeholderImageName: The name of the placeholder image. Setting this to nil will set image to nil.
    /// - Returns: The URLSessionDataTask if a retrieval from the remote source is necessary.
    @discardableResult
    public func setImageFromURL(_ url: URL?, placeholderImageName: String? = nil, directory: String? = nil, skipCache: Bool = false) -> URLSessionDataTask? {
        let image = Image(placeholderImageName: placeholderImageName, url: url)
        let cacheConfig = CacheConfig(directory: directory, imageCache: ImageCache.shared, imageHandler: PlaceholderImageHandler(), skipCache: skipCache)

        return setImage(image, withCacheConfig: cacheConfig)
    }

    // MARK: Internal Methods

    internal func setImage(_ image: Image, withCacheConfig cacheConfig: CacheConfig) -> URLSessionDataTask? {
        self.image = cacheConfig.imageHandler.placeholderImage(image.placeholderImageName, bundle: nil)

        return cacheConfig.imageHandler.image(image.url, imageCache: cacheConfig.imageCache, directory: cacheConfig.directory, skipCache: cacheConfig.skipCache, completion: { (image, source, _) in
            self.imageCompletion(image: image, source: source, imageHandler: cacheConfig.imageHandler)
        })
    }

    internal func imageCompletion(image: UIImage?, source: ImageCache.ImageSource, imageHandler: ImageHandling) {
        guard let image = image else {
            return
        }

        if source == .remote {
            imageHandler.dissolveToImage(image, onView: self)
        } else {
            imageHandler.setImage(image, onView: self)
        }
    }
}
