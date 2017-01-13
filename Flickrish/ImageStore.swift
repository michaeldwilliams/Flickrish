//
//  ImageStore.swift
//  Flickrish
//
//  Created by Michael Williams on 1/12/17.
//  Copyright © 2017 Michael D. Williams. All rights reserved.
//

import Foundation
import UIKit

enum ImageResult {
    case success(UIImage)
    case failure(Error)
}

enum Result {
    case success([Image])
    case failure(Error)
}

class ImageStore {
    
    
    let session = URLSession.shared

    // makes a netword request to get the data from the given URL
    func fetchImageJSON(completion: @escaping (Result) -> Void) {
        guard let url = URL(string: FlickrService.url) else {return}
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let jsonData = data else {return}
            let result = FlickrService.parseImages(fromJSON: jsonData)
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
        task.resume()
    }
    
    
    func fetchImage(for image: Image, completion: @escaping (ImageResult) -> Void) {
        let imageURL = image.imageURL
        let request = URLRequest(url: imageURL)
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            guard
                let imageData = data,
                let image = UIImage(data: imageData) else {return}
            let result = ImageResult.success(image)
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
        task.resume()
    }
    

}
