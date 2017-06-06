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

        viewModel.image { (image, fromCache, error) in
            let duration = fromCache ? 0.0 : 0.3
            self.cellImage.image = image

            UIView.animate(withDuration: duration, animations: { 
                self.cellImage.alpha = 1.0
            })
        }

        title.text = viewModel.title()
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        viewModel?.cancelImageDownload()
        cellImage.image = nil
        cellImage.alpha = 0.0
    }
}
