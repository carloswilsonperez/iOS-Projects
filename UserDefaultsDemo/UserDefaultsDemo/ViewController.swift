//
//  ViewController.swift
//  UserDefaultsDemo
//
//  Created by Carlos Wilson on 04/11/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    
    let defaults = UserDefaults.standard
    
    struct User: Codable {
        let name: String
        let age: Int
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        retrieveUserFromUserDefaults()
        
        // Writing data to UserDefaults
        defaults.set(22, forKey: "userAge")
        
        // Boolean
        let darkModeEnabled = true
        defaults.set(darkModeEnabled, forKey: "darkModeEnabled")
       
        // Array
        let fruits = ["Apple", "Banana", "Mango"]
        defaults.set(fruits, forKey: "favoriteFruits")

        // Dictionary
        let toggleStates = ["WiFi": true, "Bluetooth": false, "Cellular": true]
        defaults.set(toggleStates, forKey: "toggleStates")
        
        // Reading data from UserDefaults
        // In order to get data from UserDefaults, use one of its type dedicated get methods, or a generic object(forKey:) method.
        let userAge = defaults.integer(forKey: "userAge")
        let savedDarkModeEnabled = defaults.bool(forKey: "darkModeEnabled")
        let savedFruits = defaults.array(forKey: "favoriteFruits")
        let savedToggleStates = defaults.dictionary(forKey: "toggleStates")
        
        print("Saved user: \(userAge)")
        print("Saved user: \(savedDarkModeEnabled)")
        print("Saved user: \(savedFruits!)")
        print("Saved user: \(savedToggleStates!)")
    }

    @IBAction func saveUserToUserDefaults(_ sender: UIButton) {
        // Get info from TextFields
        let name = nameTextField.text ?? ""
        let age = Int(ageTextField.text!) ?? 0
        
        // Save info to UserDefaults
        let user = User(name: name, age: age)

        let encoder = JSONEncoder()
        if let encodedUser = try? encoder.encode(user) {
            defaults.set(encodedUser, forKey: "user")
        }
    }
    
    func retrieveUserFromUserDefaults() {
        // UserDefaults object -> Data -> JSONDDecoder -> User type
        if let savedUserData = defaults.object(forKey: "user") as? Data {
            let decoder = JSONDecoder()
            if let savedUser = try? decoder.decode(User.self, from: savedUserData) {
                print("Saved user: \(savedUser)")
                // Update TextFields
                nameTextField.text = "\(savedUser.name)"
                ageTextField.text = "\(savedUser.age)"
            }
        }
    }
}

