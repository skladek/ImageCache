//
//  ImagesController.swift
//  ImageCache
//
//  Created by Sean on 6/1/17.
//  Copyright © 2017 Sean Kladek. All rights reserved.
//

import UIKit

class ImagesController {
    func searchImagesFor(_ searchTerm: String) {
        let parameters = [
            "method" : "flickr.photos.search",
            "tags" : searchTerm
        ]

        FlickrController.shared.get(nil, parameters: parameters) { (objects, response, error) in
            print(response)
            print(objects)
            print(error)
        }
    }
}
