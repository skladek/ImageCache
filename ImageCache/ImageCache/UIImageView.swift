//
//  UIImageView.swift
//  ImageCache
//
//  Created by Sean on 6/7/17.
//  Copyright © 2017 Sean Kladek. All rights reserved.
//

public extension UIImageView {
    func setImageFromURL(_ url: URL, imageCache: ImageCache = ImageCache.shared) -> URLSessionDataTask? {
        return imageCache.getImage(url: url, completion: { (image, fromCache, error) in
            guard let image = image else {
                return
            }

            if fromCache == true {
                self.image = image
            } else {
                UIView.transition(with: self, duration: 0.3, options: .transitionCrossDissolve, animations: {
                    self.image = image
                }, completion: nil)
            }
        })
    }

    public func setImageFromURL(_ url: URL?, placeholderImageName: String?) -> URLSessionDataTask? {
        var placeholderImage: UIImage? = nil

        if let imageName = placeholderImageName {
            placeholderImage = UIImage(named: imageName)
        }
        self.image = placeholderImage

        guard let url = url else {
            return nil
        }

        return setImageFromURL(url)
    }
}
