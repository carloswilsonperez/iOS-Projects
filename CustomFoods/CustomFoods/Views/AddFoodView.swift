//
//  AddFoodView.swift
//  CustomFoods
//
//  Created by Carlos Wilson on 17/12/21.
//

import SwiftUI

struct AddFoodView: View {
    // State for TextFields
    @State var name: String
    @State var carbs: String
        
    // State for the alert View
    @State private var showingAlert = false
    @Environment(\.presentationMode) var presentationMode
    
    // State for the list of foods
    @ObservedObject var foodData: FoodData = FoodData()
    
    var body: some View {
        VStack {
            Form(content: {
                
                Section(header: Text("FOOD NAME")
                            .foregroundColor(.black)
                            .font(.headline).bold()) {
                    TextField("Enter food name", text: $name)
                }.textCase(nil)
                
                Section(header: Text("CARBS (g)")
                            .foregroundColor(.black)
                            .font(.headline).bold()
                            ) {
                    TextField("Enter carb name", text: $carbs)
                        .keyboardType(.numberPad)
                }.textCase(nil)
            })
            .navigationBarTitle("Add Custom Food")
            
            Spacer()
            Button(action: {
                showingAlert = true
            }, label: {
                Text("Save To Custom Foods")
                    .fontWeight(.medium)
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: 300, maxHeight: 20)
                    .padding()
                    .foregroundColor(Color.white)
                    .background(Color(red: 98/255, green: 0.0, blue: 234/255))
                    .cornerRadius(8)
            })
            .disabled(name == "")
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Custom Foods"),
                      message: Text("Your custom fod \(name) for \(carbs)g has been added"),
                      dismissButton: Alert.Button.default(
                        Text("Ok"), action: {
                            // Append new Food item to the foodData.foods array
                            foodData.addFood(food: Food(name: name, carbohidrates: Int(carbs)!))
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    )
                )
            }
        }
    }
}

struct AddFoodView_Previews: PreviewProvider {
    static var previews: some View {
        AddFoodView(name: "", carbs: "", foodData: FoodData())
    }
}
