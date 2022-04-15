//
//  Food.swift
//  CustomFoods
//
//  Created by Carlos Wilson on 17/12/21.
//

import Foundation

struct Food : Identifiable {
    var id = UUID()
    var name: String = ""
    var carbohidrates: Int = 0
}

struct MenuItem : Identifiable {
    var id = UUID()
    var label: String = ""
    var icon: String = ""
}

final class Menu {
    static var menuItems = [
        MenuItem(label: "Switch Mode", icon: "switch.2"),
        MenuItem(label: "Set Temp Basal", icon: "circle.grid.cross"),
        MenuItem(label: "Hypo Protect", icon: "cross"),
        MenuItem(label: "Pod", icon: "capsule"),
        MenuItem(label: "Enter BG", icon: "waveform.path.ecg"),
        MenuItem(label: "Suspend Insulin", icon: "xmark"),
        MenuItem(label: "Basal Programs", icon: ""),
        MenuItem(label: "Temp Basal Presets", icon: ""),
        MenuItem(label: "Custom Foods", icon: ""),
        MenuItem(label: "Edit Settings", icon: "")
    ]
}

final class FoodData: ObservableObject {
    @Published var foods: [Food] = [
        Food(name:"Banana",carbohidrates: 28),
        Food(name:"Coffee", carbohidrates: 55),
        Food(name:"Pizza", carbohidrates: 22)
    ]
    
    func addFood(food: Food) {
        foods.append(food)
    }
}
