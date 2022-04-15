//
//  CustomFoodsApp.swift
//  CustomFoods
//
//  Created by Carlos Wilson on 17/12/21.
//

import SwiftUI

@main
struct CustomFoodsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainView(foodData: FoodData())
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
