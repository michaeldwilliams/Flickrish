//
//  Image.swift
//  Flickrish
//
//  Created by Michael Williams on 1/12/17.
//  Copyright © 2017 Michael D. Williams. All rights reserved.
//

import Foundation

class Image {
    
    let title:String
    let imageURL:URL
    
    init(title:String, imageURL:URL) {
        self.title = title
        self.imageURL = imageURL
    }
    
}

extension Image: Equatable {
    static func == (lhs: Image, rhs: Image) -> Bool {
        return lhs.imageURL == rhs.imageURL
    }
}
