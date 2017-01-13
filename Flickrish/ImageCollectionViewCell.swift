//
//  ImageCollectionViewCell.swift
//  Flickrish
//
//  Created by Michael Williams on 1/12/17.
//  Copyright © 2017 Michael D. Williams. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    func updateImageView(with image: UIImage?) {
        if let _image = image {
            activityIndicator.stopAnimating()
            imageView.image = _image
        } else {
            activityIndicator.startAnimating()
            imageView.image = nil
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        updateImageView(with: nil)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        updateImageView(with: nil)
    }
    
}
