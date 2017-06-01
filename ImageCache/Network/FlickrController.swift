//
//  FlickrController.swift
//  ImageCache
//
//  Created by Sean on 6/1/17.
//  Copyright © 2017 Sean Kladek. All rights reserved.
//

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
    }
}
