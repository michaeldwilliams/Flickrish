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
    
    func update(with image: UIImage?) {
        if let imageToDisplay = image {
            activityIndicator.stopAnimating()
            imageView.image = imageToDisplay
        } else {
            activityIndicator.startAnimating()
            imageView.image = nil
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        update(with: nil)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        update(with: nil)
    }
    
}
