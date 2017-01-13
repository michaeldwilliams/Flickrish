//
//  ViewImageViewController.swift
//  Flickrish
//
//  Created by Michael Williams on 1/12/17.
//  Copyright © 2017 Michael D. Williams. All rights reserved.
//

import UIKit

class ViewImageViewController: UIViewController {

   @IBOutlet weak var imageView: UIImageView!
    var image: Image! {
        didSet {
            navigationItem.title = image.title
        }
    }
    var store: ImageStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        store.fetchImage(for: image) { (result) -> Void in
            switch result {
            case let .success(image):
                self.imageView.image = image
            case let .failure(error):
                print("Error fetching image for photo: \(error)")
            }
        }
    }


}
