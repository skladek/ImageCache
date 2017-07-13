import UIKit

public extension UIImageView {

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
        return setImageFromURL(url, placeholderImageName: placeholderImageName, imageCache: ImageCache.shared, imageHandler: PlaceholderImageHandler(), directory: directory, skipCache: skipCache)
    }

    // MARK: Internal Methods

    internal func setImageFromURL(_ url: URL?, placeholderImageName: String?, imageCache: ImageCache, imageHandler: ImageHandling, directory: String?, skipCache: Bool) -> URLSessionDataTask? {
        self.image = imageHandler.placeholderImage(placeholderImageName, bundle: nil)

        return imageHandler.image(url, imageCache: imageCache, directory: directory, skipCache: skipCache, completion: { (image, source, _) in
            self.imageCompletion(image: image, source: source, imageHandler: imageHandler)
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
