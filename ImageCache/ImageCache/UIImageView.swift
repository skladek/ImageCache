//
//  UIImageView.swift
//  ImageCache
//
//  Created by Sean on 6/7/17.
//  Copyright © 2017 Sean Kladek. All rights reserved.
//

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
    public func setImageFromURL(_ url: URL?, placeholderImageName: String?) -> URLSessionDataTask? {
        return setImageFromURL(url, placeholderImageName: placeholderImageName, imageCache: ImageCache.shared, imageHandler: PlaceholderImageHandler())
    }

    // MARK: Internal Methods

    internal func setImageFromURL(_ url: URL?, placeholderImageName: String?, imageCache: ImageCache, imageHandler: ImageHandling) -> URLSessionDataTask? {
        self.image = imageHandler.placeholderImage(placeholderImageName, bundle: nil)

        return imageHandler.image(url, imageCache: imageCache, completion: { (image, fromCache, error) in
            self.imageCompletion(image: image, fromCache: fromCache, imageHandler: imageHandler)
        })
    }

    internal func imageCompletion(image: UIImage?, fromCache: Bool, imageHandler: ImageHandling) -> () {
        guard let image = image else {
            return
        }

        if fromCache == true {
            imageHandler.setImage(image, onView: self)
        } else {
            imageHandler.dissolveToImage(image, onView: self)
        }
    }
}
