//
//  ImagesController.swift
//  ImageCache
//
//  Created by Sean on 6/1/17.
//  Copyright © 2017 Sean Kladek. All rights reserved.
//

import UIKit

class ImagesController {
    func searchImagesFor(_ searchTerm: String?, completion: @escaping ([Image]?, Error?) -> ()) {
        guard let searchTerm = searchTerm else {
            return
        }

        let parameters = [
            "method" : "flickr.photos.search",
            "tags" : searchTerm
        ]

        FlickrController.shared.get(nil, parameters: parameters) { (object, response, error) in
            guard let object = object as? [String : Any] else {
                completion(nil, error)
                return
            }
            guard let photosJSON = object["photos"] as? [String : Any] else {
                completion(nil, error)
                return
            }
            guard let imagesDictionaries = photosJSON["photo"] as? [[String : Any]] else {
                completion(nil, error)
                return
            }

            var images = [Image]()

            for dictionary in imagesDictionaries {
                if let image = Image(dictionary: dictionary) {
                    images.append(image)
                }
            }

            completion(images, error)
        }
    }
}
