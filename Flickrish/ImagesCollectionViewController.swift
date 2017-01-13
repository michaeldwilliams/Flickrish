//
//  ImagesCollectionViewController.swift
//  Flickrish
//
//  Created by Michael Williams on 1/12/17.
//  Copyright © 2017 Michael D. Williams. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ImageCollectionViewCell"

class ImagesCollectionViewController: UICollectionViewController {
    
    let store = ImageStore()
    var images = [Image]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        store.fetchImageJSON { (result) in
            switch result {
            case let .success(images):
                self.images = images
                print("Found \(images.count) images.")
            case let .failure(error):
                self.images.removeAll()
                print("Error fetching images: \(error)")
            }
            self.collectionView?.reloadSections(IndexSet(integer: 0))
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewImageSegue" {
            if let selectedIndexPath =
                collectionView?.indexPathsForSelectedItems?.first {
                let image = self.images[selectedIndexPath.row]
                let destinationViewController = segue.destination as! ViewImageViewController
                destinationViewController.image = image
                destinationViewController.store = store
            }
        }
        
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageCollectionViewCell
        return cell
    }

    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let photo = self.images[indexPath.row]
        store.fetchImage(for: photo) { (result) -> Void in
            guard let photoIndex = self.images.index(of: photo),
                case let .success(image) = result else {
                    return
            }
            let photoIndexPath = IndexPath(item: photoIndex, section: 0)
            if let cell = self.collectionView?.cellForItem(at: photoIndexPath) as? ImageCollectionViewCell {
                cell.updateImageView(with: image)
        }
    } }
    
    
}
