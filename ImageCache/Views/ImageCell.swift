//
//  ImageCell.swift
//  ImageCache
//
//  Created by Sean on 6/1/17.
//  Copyright © 2017 Sean Kladek. All rights reserved.
//

import UIKit

class ImageCell: UITableViewCell {

    @IBOutlet weak var cellImage: UIImageView!

    @IBOutlet weak var title: UILabel!

    func setViewModel(_ viewModel: ImageViewModel) {
        viewModel.image { (image, error) in
            self.cellImage.image = image

            print(error)
        }

        title.text = viewModel.title()
    }
}
