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
    enum Endpoint {
        case randomImageFromAllDogsCollection
        case randomImageForBreed(String)
        case listAllBreeds
        
        var url: URL {
            return URL(string: self.stringValue)!
        }
        
        var stringValue: String {
            switch self {
            case .randomImageFromAllDogsCollection:
                return "https://dog.ceo/api/breeds/image/random"
            case .randomImageForBreed(let breed):
                return "https://dog.ceo/api/breed/\(breed)/images/random"
            case .listAllBreeds:
                return "https://dog.ceo/api/breeds/list/all"
            }
        }
        
    }
        
        class func requestBreedsList(completionHandler: @escaping ([String], Error?) -> Void) {
            
            let task = URLSession.shared.dataTask(with: Endpoint.listAllBreeds.url) { (data, response, error) in
                guard let data = data else {
                    completionHandler([], error)
                    return
                }
                
                let decoder = JSONDecoder()
                let breedsResponse = try! decoder.decode(BreedsListResponse.self, from: data)
                let breeds = breedsResponse.message.keys.map({$0})
                completionHandler(breeds, nil)
            }
            task.resume()
            
        }
        
        // Because completionHandler will be called after function finishes executing, we call @escaping
        class func requestRandomImage(breed: String, completionHandler: @escaping (DogImage?, Error?) -> Void) {
            // Start with URL to fetch a random image
            let randomImageEndpoint = DogAPI.Endpoint.randomImageForBreed(breed).url
            
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
        
    
    

