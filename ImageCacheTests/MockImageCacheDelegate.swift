//
//  MockImageCacheDelegate.swift
//  ImageCache
//
//  Created by Sean on 6/6/17.
//  Copyright © 2017 Sean Kladek. All rights reserved.
//

import Foundation

@testable import ImageCache

class MockImageCacheDelegate: ImageCacheDelegate {
    var loadImageAtURLCalled = false

    func loadImageAtURL(_ url: URL, completion: @escaping ImageCache.RemoteImageCompletion) -> URLSessionDataTask? {
        loadImageAtURLCalled = true

        let bundle = Bundle(for: type(of: self))
        let image = UIImage(named: "testimage", in: bundle, compatibleWith: nil)

        completion(image, nil)

        return nil
    }
}
