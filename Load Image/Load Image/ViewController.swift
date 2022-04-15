//
//  ViewController.swift
//  Load Image
//
//  Created by Carlos Wilson on 05/02/21.
//

import UIKit

enum KittenImageLocation: String {
    case http = "http://www.kittenswhiskers.com/wp-content/uploads/sites/23/2014/02/Kitten-playing-with-yarn.jpg"
    case https = "https://upload.wikimedia.org/wikipedia/commons/thumb/0/06/Kitten_in_Rizal_Park%2C_Manila.jpg/460px-Kitten_in_Rizal_Park%2C_Manila.jpg"
    case error = "not a url"
}

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    let imageLocation = KittenImageLocation.https.rawValue

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    @IBAction func handleLoadImageButtonPress(_ sender: Any) {
        guard let imageURL = URL(string: imageLocation) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            guard let data = data else {
                return
            }
            
            let downloadedImage = UIImage(data: data)
            
            DispatchQueue.main.async {
                self.imageView.image = downloadedImage
            }
        }
        
        task.resume()
        
    }
    
}

