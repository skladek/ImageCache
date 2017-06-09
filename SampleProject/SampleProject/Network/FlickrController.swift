//
//  FlickrController.swift
//  ImageCache
//
//  Created by Sean on 6/1/17.
//  Copyright © 2017 Sean Kladek. All rights reserved.
//

import SKImageCache
import UIKit

class FlickrController: WebServiceController {
    static let shared = FlickrController()

    init() {
        let defaultParameters = [
            "api_key" : kAPI_KEY,
            "format" : "json",
            "nojsoncallback" : "1",
        ]

        super.init(baseURL: kBASE_URL, defaultParameters: defaultParameters)

        ImageCache.shared.delegate = self
    }
}

extension FlickrController: ImageCacheDelegate {
    func loadImageAtURL(_ url: URL, completion: @escaping ImageCache.RemoteImageCompletion) -> URLSessionDataTask? {
        return getImage(url) { (image, response, error) in
            completion(image, error)
        }
    }
}
