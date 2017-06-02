//
//  ImageCache.swift
//  ImageCache
//
//  Created by Sean on 6/1/17.
//  Copyright © 2017 Sean Kladek. All rights reserved.
//

import UIKit

protocol ImageCacheDelegate {
    func loadImageAtURL(_ url: URL, completion: @escaping ImageCache.ImageCompletion) -> URLSessionDataTask?
}

class ImageCache {
    typealias ImageCompletion = (UIImage?, Error?) -> ()

    static let shared = ImageCache()

    var delegate: ImageCacheDelegate?

    private let cache = NSCache<AnyObject, UIImage>()

    func cacheImage(_ image: UIImage?, forURL url: URL) {
        guard let image = image else {
            return
        }

        cache.setObject(image, forKey: url.absoluteString as AnyObject)
    }

    func getImage(url: URL, completion: @escaping ImageCompletion) -> URLSessionDataTask? {
        if let image = retrieveFromCache(url: url) {
            completion(image, nil)
            return nil
        }

        return delegate?.loadImageAtURL(url, completion: completion)
    }

    private func retrieveFromCache(url: URL) -> UIImage? {
        return cache.object(forKey: url.absoluteString as AnyObject)
    }
}
