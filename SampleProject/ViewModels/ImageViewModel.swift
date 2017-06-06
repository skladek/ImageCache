//
//  ImageViewModel.swift
//  ImageCache
//
//  Created by Sean on 6/1/17.
//  Copyright © 2017 Sean Kladek. All rights reserved.
//

import UIKit

class ImageViewModel: NSObject {

    let image: Image

    private var imageDownloadTask: URLSessionDataTask?

    init(image: Image) {
        self.image = image
    }

    func cancelImageDownload() {
        imageDownloadTask?.cancel()
    }

    func image(completion: @escaping ImageCache.ImageCompletion) {
        guard let url = image.imageURL() else {
            return
        }

        imageDownloadTask = ImageCache.shared.getImage(url: url, completion: completion)
    }

    func title() -> String {
        return image.title
    }
}
