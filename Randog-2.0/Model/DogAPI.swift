//
//  DogAPI.swift
//  Randog-2.0
//
//  Created by Michael Haviv on 11/12/19.
//  Copyright © 2019 Michael Haviv. All rights reserved.
//

import Foundation
import UIKit

class DogAPI {
    enum Endpoint: String {
        case randomImageFromAllDogsCollection = "https://dog.ceo/api/breeds/image/random"
        
        var url: URL {
            return URL(string: self.rawValue)!
        }
    }
    
    // Because completionHandler will be called after function finishes executing, we call @escaping
    class func requestRandomImage(completionHandler: @escaping (DogImage?, Error?) -> Void) {
        // Start with URL to fetch a random image
        let randomImageEndpoint = DogAPI.Endpoint.randomImageFromAllDogsCollection.url
        
        // Fetch the json response containg the image's URL
        let task = URLSession.shared.dataTask(with: randomImageEndpoint) { (data, response, error) in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            
            // Parse the json using JSONDecoder
            let decoder = JSONDecoder()
            let imageData = try! decoder.decode(DogImage.self, from: data)
            print(imageData)
            completionHandler(imageData, nil)
            
        }
        task.resume()
    }
    
    // Don't need instance of DogAPI class to use it (so mark it as class)
    // UIImage/Error are optional because if there is image then error is nil if not UIImage is nil
    class func requestImageFile(url: URL, completionHandler: @escaping (UIImage?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
        guard let data = data else {
            completionHandler(nil, error)
            return
        }
        
        // Load the image to the image view
        let downloadedImage = UIImage(data: data)
        completionHandler(downloadedImage, nil)
        })
        task.resume()
    }
}
