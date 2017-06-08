//
//  PlaceholderImageHandler.swift
//  ImageCache
//
//  Created by Sean on 6/7/17.
//  Copyright © 2017 Sean Kladek. All rights reserved.
//

import Foundation

protocol ImageHandling {
    func dissolveToImage(_ image: UIImage, onView view: UIImageView)
    func image(_ url: URL?, imageCache: ImageCache, completion: @escaping ImageCache.ImageCompletion) -> URLSessionDataTask?
    func placeholderImage(_ imageName: String?, bundle: Bundle?) -> UIImage?
    func setImage(_ image: UIImage, onView view: UIImageView)
}

class PlaceholderImageHandler: ImageHandling {

    // MARK: Internal Methods

    func dissolveToImage(_ image: UIImage, onView view: UIImageView) {
        UIView.transition(with: view, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.setImage(image, onView: view)
        }, completion: nil)
    }

    func image(_ url: URL?, imageCache: ImageCache, completion: @escaping ImageCache.ImageCompletion) -> URLSessionDataTask? {
        guard let url = url else {
            return nil
        }

        return imageCache.getImage(url: url, completion: completion)
    }

    func placeholderImage(_ imageName: String?, bundle: Bundle? = nil) -> UIImage? {
        var placeholderImage: UIImage? = nil

        if let imageName = imageName {
            placeholderImage = UIImage(named: imageName, in: bundle, compatibleWith: nil)
        }

        return placeholderImage
    }

    func setImage(_ image: UIImage, onView view: UIImageView) {
        view.image = image
    }
}
