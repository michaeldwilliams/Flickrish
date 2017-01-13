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

enum PhotoError: Error {
    case imageCreationError
}

enum Result {
    case success([Image])
    case failure(Error)
}

class ImageStore {
    
    
    private let session:URLSession = {
        let configuration = URLSessionConfiguration.default
        return URLSession(configuration: configuration)
    }()

    
    func fetchImages(completion: @escaping (Result) -> Void) {
        guard let url = URL(string: FlickrService.url) else {return}
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { (data, response, error) in
            let result = self.processImageJSON(data: data, error: error)
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
        task.resume()
    }
    
    private func processImageJSON(data:Data?, error:Error?) -> Result {
        guard let jsonData = data else {return .failure(error!)}
        return FlickrService.parseImages(fromJSON: jsonData)
    }
        
    func fetchImage(for image: Image, completion: @escaping (ImageResult) -> Void) {
        let imageURL = image.imageURL
        let request = URLRequest(url: imageURL)
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            let result = self.processImageRequest(data: data, error: error)
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
        task.resume()
    }
    
    private func processImageRequest(data: Data?, error: Error?) -> ImageResult {
        guard
            let imageData = data,
            let image = UIImage(data: imageData) else {
                
                if data == nil {
                    return .failure(error!)
                } else {
                    return .failure(PhotoError.imageCreationError)
                }
        }
        return .success(image)
    }

}
