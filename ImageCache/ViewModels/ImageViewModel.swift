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

    init(image: Image) {
        self.image = image
    }

    func image(completion: @escaping (UIImage?, Error?) -> ()) {
        guard let url = image.imageURL() else {
            return
        }

        FlickrController.shared.getImage(url) { (image, response, error) in
            completion(image, error)
        }
    }

    func title() -> String {
        return image.title
    }
}
