//
//  UIImageView.swift
//  ImageCache
//
//  Created by Sean on 6/7/17.
//  Copyright © 2017 Sean Kladek. All rights reserved.
//

public extension UIImageView {
    // MARK: Public Methods

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
