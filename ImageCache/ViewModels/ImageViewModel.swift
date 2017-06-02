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

    func image(completion: @escaping (UIImage?, Error?) -> ()) {
        guard let url = image.imageURL() else {
            return
        }

        imageDownloadTask = FlickrController.shared.getImage(url) { (image, response, error) in
            completion(image, error)
        }
    }

    func title() -> String {
        return image.title
    }
}
