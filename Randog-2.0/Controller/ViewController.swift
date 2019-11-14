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
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    let breeds: [String] = ["greyhound", "poodle"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.dataSource = self
        pickerView.delegate = self

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

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    // User selects 1 value
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Options populated from array
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return breeds.count
    }
    
    // Returns a breed that will be displayed in the pickerView
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return breeds[row]
    }
    
    // When the pickerView stops spinning and a breed is selected we want it to call requesRandom Image to fetch an image
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        DogAPI.requestRandomImage(completionHandler: handleRandomImageResponse(imageData:error:))
    }
    
}
