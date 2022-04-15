//
//  Navigations.swift
//  SwiftUI2
//
//  Created by Carlos Wilson on 29/08/21.
//

import SwiftUI

struct Navigations: View {
    
    @State var imagenesIsActive:Bool = false

    var body: some View {
        NavigationView {
                    
                    VStack{
                        
                        Text("Hola Mundo").navigationTitle("Primer pantalla").padding(.bottom,18 )
                        
                        Button(action: {
                            print("Button tapped!")
                        }) {
                            Text("Press Me")
                        }.frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).background(Color.red)
                        
                        NavigationLink("Divisores", destination: ZStack())
                        
                        
                        Button(action: {imagenesIsActive = true}, label: {
                                Image("platzi").resizable().aspectRatio(contentMode: .fit).frame(width: 150, height: 150)                })
                        
                        
                        NavigationLink(
                            destination: ZStack(),
                            isActive: $imagenesIsActive,
                            label: {
                                EmptyView()
                            })
                        
                    }
                }
                
    }
}

struct Navigations_Previews: PreviewProvider {
    static var previews: some View {
        Navigations()
    }
}
