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

    private var viewModel: ImageViewModel?

    func setViewModel(_ viewModel: ImageViewModel) {
        self.viewModel = viewModel

        viewModel.image { (image, error) in
            self.cellImage.image = image
        }

        title.text = viewModel.title()
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        viewModel?.cancelImageDownload()
        cellImage.image = nil
    }
}
