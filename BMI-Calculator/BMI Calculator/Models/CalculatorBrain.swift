//
//  CalculatorBrain.swift
//  BMI Calculator
//
//  Created by Carlos Wilson on 28/08/2019.
//  Copyright © 2019 Carlos Wilson. All rights reserved.
//

import UIKit

struct CalculatorBrain {
    
    var bmi: BMI?
    
    func getBMIValue() -> String {
        let bmiTo1DecimalPlace = String(format: "%.1f", bmi?.value ?? 0.0)
        return bmiTo1DecimalPlace
    }
    
    func getAdvice() -> String {
        return bmi?.advice ?? "No advice"
    }
    
    func getColor() -> UIColor {
        return bmi?.color ?? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    mutating func calculateBMI(height: Float, weight: Float) {
        let bmiValue = weight / (height * height)

        if bmiValue < 18.5 {
            bmi = BMI(value: bmiValue, advice: "Eat more pies!", color: UIColor(named: "Green")!)
        } else if bmiValue < 24.9 {
            bmi = BMI(value: bmiValue, advice: "Fit as a fiddle!", color: UIColor(named: "Gray")!)
        } else {
            bmi = BMI(value: bmiValue, advice: "Eat less pies!", color: UIColor(named: "Red")!)
        }
    }
}
