//
//  ViewController.swift
//  Dog Api
//
//  Created by Carlos Wilson on 05/02/21.
//

import UIKit

enum RandomDog: String {
    case https = "https://dog.ceo/api/breeds/image/random"
}

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var loadDogButton: UIButton!

    let imageLocation = RandomDog.https.rawValue
    
    var breeds: [String] = []
    var selectedBreed: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pickerView.dataSource = self
        pickerView.delegate = self
        
        loadDogButton.layer.cornerRadius = loadDogButton.frame.height / 2
        
        DogAPI.requestBreedsList(completionHandler: handleBreedsListResponse(breeds:error:))
    }
    
    @IBAction func loadADog(_ sender: Any) {
        DogAPI.requestRandomImage(breed: self.selectedBreed, completionHandler: self.handleRandomImageResponse(url:error:))
    }
    
    func handleRandomImageResponse(url: URL, error: Error?) {
        DogAPI.requestImageFile(url: url, completionHandler: self.handleImageFileResponse(image:error:))
    }
    
    func handleImageFileResponse(image: UIImage?, error: Error?) {
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
    
    func handleBreedsListResponse(breeds: [String], error: Error?) {
        self.breeds = breeds
        
        // Set the initial breed at start up
        self.selectedBreed = breeds[0]
        self.pickerView.selectRow(0, inComponent: 0, animated: false)

        DispatchQueue.main.async {
            self.pickerView.reloadAllComponents()
        }
    }
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return breeds.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return breeds[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedBreed = breeds[row]
        DogAPI.requestRandomImage(breed: breeds[row], completionHandler: self.handleRandomImageResponse(url:error:))
    }
}



