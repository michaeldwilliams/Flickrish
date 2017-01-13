//
//  FlickrService.swift
//  Flickrish
//
//  Created by Michael Williams on 1/12/17.
//  Copyright © 2017 Michael D. Williams. All rights reserved.
//

import Foundation
import UIKit

enum ServiceError:Error {
    case invalidJSONData
}

struct FlickrService {
    
    static let url = "https://api.flickr.com/services/rest/?method=flickr.interestingness.getList&api_key=a6d819499131071f158fd740860a5a88&extras=url_h%2Curl_t&format=json&nojsoncallback=1"

    // Using the JSON to return an array of Image(s)
    static func parseImages(fromJSON data:Data) -> Result {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            guard
                let jsonDictionary = jsonObject as? [AnyHashable:Any],
                let images = jsonDictionary["photos"] as? [String:Any],
                let imagesArray = images["photo"] as? [[String:Any]]
                else {
                    return .failure(ServiceError.invalidJSONData)
            }
            var imageOutput = [Image]()
            for imageDict in imagesArray {
                if let image = parseImageData(from: imageDict) {
                    imageOutput.append(image)
                }
            }
            return .success(imageOutput)
        }
        catch let error {
            return .failure(error)
        }
    }
    
    // Parse the larger data-filled collection into just the necessary parts  
    private static func parseImageData(from dictionary:[String:Any]) -> Image? {
        guard
            let title = dictionary["title"] as? String,
            let urlString = dictionary["url_h"] as? String,
            let url = URL(string: urlString) else {
                return nil
        }
        return Image(title: title, imageURL: url)
    }

}
