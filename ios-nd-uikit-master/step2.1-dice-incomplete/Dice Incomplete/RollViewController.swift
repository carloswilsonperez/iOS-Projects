//
//  RollViewController.swift
//  Dice
//
//  Created by Jason Schatz on 11/6/14.
//  Copyright (c) 2014 Udacity. All rights reserved.
//

import UIKit

// MARK: - RollViewController: UIViewController

class RollViewController: UIViewController {
    
    // MARK: Generate Dice Value
    
    /**
    * Randomly generates a Int from 1 to 6
    */
    func randomDiceValue() -> Int {
        // Generate a random Int32 using arc4Random
        let randomValue = 1 + arc4random() % 6
        
        // Return a more convenient Int, initialized with the random value
        return Int(randomValue)
    }

    // MARK: Actions
    // This is an example without Segues
    @IBAction func rollTheDice() {
        // Get the DiceViewController
        let controller: DiceViewController
        controller = storyboard?.instantiateViewController(withIdentifier: "DiceViewController") as! DiceViewController

        // Set the two values to random numbers from 1 to 6
        controller.firstValue = randomDiceValue()
        controller.secondValue = randomDiceValue()

        // Present the view Controller
        present(controller, animated: true, completion: nil)
    }
}

