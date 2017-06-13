//
//  MockImageCache.swift
//  ImageCache
//
//  Created by Sean on 6/7/17.
//  Copyright © 2017 Sean Kladek. All rights reserved.
//

import Foundation

@testable import SKImageCache

class MockImageCache: ImageCache {
    var getImageCalled = false

    override func getImage(url: URL, skipCache: Bool, completion: @escaping ImageCache.ImageCompletion) -> URLSessionDataTask? {
        getImageCalled = true

        return URLSessionDataTask()
    }
}
