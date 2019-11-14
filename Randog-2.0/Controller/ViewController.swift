//
//  ViewController.swift
//  Randog-2.0
//
//  Created by Michael Haviv on 11/12/19.
//  Copyright © 2019 Michael Haviv. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        DogAPI.requestRandomImage(completionHandler: handleRandomImageResponse(imageData:error:))

    }
    
    func handleRandomImageResponse(imageData: DogImage?, error: Error?) {
        guard let imageURL = URL(string: imageData?.message ?? "") else { return }
        
        DogAPI.requestImageFile(url: imageURL, completionHandler: self.handleImageFileResponse(image:error:))
    }
    
    func handleImageFileResponse(image: UIImage?, error: Error?) {
        //  We can only update UI on the main thread
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }


}

