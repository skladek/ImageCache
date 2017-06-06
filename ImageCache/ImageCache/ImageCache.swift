//
//  ImageCache.swift
//  ImageCache
//
//  Created by Sean on 6/1/17.
//  Copyright © 2017 Sean Kladek. All rights reserved.
//

import UIKit

public protocol ImageCacheDelegate {
    func loadImageAtURL(_ url: URL, completion: @escaping ImageCache.RemoteImageCompletion) -> URLSessionDataTask?
}

public class ImageCache {

    // MARK: Class Types

    public typealias ImageCompletion = (UIImage?, Bool, Error?) -> ()

    public typealias RemoteImageCompletion = (UIImage?, Error?) -> ()

    // MARK: Class Variables

    public static let shared = ImageCache()

    // MARK: Instance Variables

    public var delegate: ImageCacheDelegate?

    // MARK: Private Variables

    private let cache = NSCache<AnyObject, UIImage>()

    // MARK: Instance Methods

    public func cacheImage(_ image: UIImage?, forURL url: URL) {
        guard let image = image else {
            return
        }

        let imageName = imageNameFromURL(url) as AnyObject
        cache.setObject(image, forKey: imageName)
    }

    public func emptyCache() {
        cache.removeAllObjects()
    }

    public func getImage(url: URL, skipCache: Bool = false, completion: @escaping ImageCompletion) -> URLSessionDataTask? {
        if let image = retrieveFromCache(url: url), skipCache == false {
            completion(image, true, nil)
            return nil
        }

        return delegate?.loadImageAtURL(url, completion: { (image, error) in
            completion(image, false, error)
        })
    }

    public func removeObjectAtURL(_ url: URL) {
        let imageName = imageNameFromURL(url) as AnyObject
        cache.removeObject(forKey: imageName)
    }

    // MARK: Private Methods

    private func imageNameFromURL(_ url: URL) -> String {
        return url.lastPathComponent
    }

    private func retrieveFromCache(url: URL) -> UIImage? {
        let imageName = imageNameFromURL(url) as AnyObject
        return cache.object(forKey: imageName)
    }
}
