//
//  MenuView.swift
//  CustomFoods
//
//  Created by Carlos Wilson on 17/12/21.
//

import SwiftUI

struct Todo: Identifiable{
    let id = UUID()
    let name: String
    let category: String
}

struct FoodsListView: View {
    
    @State private var showAddTodoView = false
    @EnvironmentObject var foodData: FoodData
    
    init() {
        UITableViewCell.appearance().backgroundColor = .white
        UITableView.appearance().backgroundColor = .white
    }
    
    var body: some View {
        VStack {
            List{
                ForEach(foodData.foods){ food in
                    HStack{
                        Text(food.name)
                        Spacer()
                        Text("\(food.carbohidrates) g")
                            .foregroundColor(Color.purple)
                    }
                    .listRowSeparator(.hidden)
                    Divider()
                }
                .onDelete(perform: { indexSet in
                    foodData.foods.remove(atOffsets: indexSet)
                })
                .onMove(perform: { indices, newOffset in
                    foodData.foods.move(fromOffsets: indices, toOffset: newOffset)
                })
            }
            Spacer()
            NavigationLink(destination: AddFoodView(name: "", carbs: "", foodData: foodData)) {
                Text("Add Custom Food")
                    .fontWeight(.medium)
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: 300, maxHeight: 20)
                    .padding()
                    .foregroundColor(Color.white)
                    .background(Color(red: 98/255, green: 0.0, blue: 234/255))
                    .cornerRadius(8)
            }
        }
        .background(Color.white)
        .navigationBarTitle("Custom Foods")
        .navigationBarItems(trailing: EditButton())
    }
    /*
     struct AddTodoView: View {
     @Binding var showAddTodoView: Bool
     
     @State private var name: String = ""
     @State private var selectedCategory = 0
     var categoryTypes = ["family","personal","work"]
     
     @Binding var todos: [Todo]
     
     var body: some View {
     
     VStack{
     Text("Add Todo").font(.largeTitle)
     TextField("To Do name",text: $name)
     .textFieldStyle(RoundedBorderTextFieldStyle())
     .border(Color.black).padding()
     
     Text("Select Category")
     Picker("",selection: $selectedCategory){
     ForEach(0 ..< categoryTypes.count){
     Text(self.categoryTypes[$0])
     }
     }.pickerStyle(SegmentedPickerStyle())
     
     }.padding()
     
     Button(action: {
     self.showAddTodoView = false
     todos.append(Todo(name: name, category: categoryTypes[selectedCategory]))
     },
     label: {
     Text("Done")
     })
     }
     }
     
     */
}
struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        FoodsListView().environmentObject(FoodData())
    }
}
