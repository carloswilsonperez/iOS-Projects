//
//  Double+Extensions.swift
//  ios-weather-app
//
//  Created by Carlos Wilson on 7/3/20.
//  Copyright © 2020 Carlos Wilson. All rights reserved.
//

import Foundation

extension Double {
    
    func toString() -> String {
        return String(format: "%.1f", self)
    }
    
    func toInt() -> Int {
        return Int(self)
    }
    
}
