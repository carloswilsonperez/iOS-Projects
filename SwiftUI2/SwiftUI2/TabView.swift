//
//  TabView.swift
//  SwiftUI2
//
//  Created by Carlos Wilson on 29/08/21.
//

import SwiftUI

struct TabView2: View {
    var body: some View {
        TabView {
                   
           ContentView()
                .tabItem {
                   Image(systemName: "play")
                   Text("Imagenes")
                 }
           
            ContentView().tabItem {
               
               Image(systemName: "line.diagonal")
               Text("divisores")
               
           }
           
            ContentView().tabItem { Label("Stacks", systemImage: "square.grid.3x1.below.line.grid.1x2") }
                   
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabView2()
    }
}
