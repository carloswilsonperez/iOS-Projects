//
//  ViewController.swift
//  SimpleHTTPDemo
//
//  Created by Carlos Wilson on 09/10/21.
//

import UIKit

class ViewController: UIViewController {
    
    /*
     http://www.mocky.io/v2/5e2674472f00002800a4f417
     
     {
     "user": "@carlosmejia083",
     "age": 24,
     "isHappy": true
     }
     */
    
    // MARK: - Referencias UI
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchService()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }
    
    // 1. Crear expeción de seguridad - Ok
    // 2. Crear URL con el endpoint. - OK
    // 3. Hacer request con la ayuda de URLSession
    // 4. Transformar respuesta a diccionario
    // 5. Ejecutar Request
    
    private func fetchService() {
        let endpointString = "http://www.mocky.io/v2/5e2674472f00002800a4f417"

        guard let endpoint = URL(string: endpointString) else {

            return
        }
        
        URLSession.shared.dataTask(with: endpoint) {
            (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print("Hubo un error!")
                
                return
            }
          
            guard let dataFromService = data,
                  let dictionary = try? JSONSerialization.jsonObject(with: dataFromService, options: []) as? [String: Any] else {
                
                return
            }
            
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.nameLabel.text = dictionary["user"] as? String
                let isHappy = dictionary["isHappy"] as? Bool
                self.statusLabel.text = String(isHappy!)
            }
            
        }.resume()
    }
}

