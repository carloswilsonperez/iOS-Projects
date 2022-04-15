//
//  ContentView.swift
//  SwiftUI2
//
//  Created by Carlos Wilson on 27/08/21.
//

import SwiftUI

struct ContentView: View {
    @State var buttonLabel = "Click Here"
    
    var body: some View {
        VStack {
            Text(buttonLabel)
                .foregroundColor(.blue)
                .padding()
                .frame(width: 300, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(Color.gray)
            
            TextField("Enter something...", text: $buttonLabel)
            
            Divider().frame(height: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).background(Color.red)
            
            Circle().frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            
            VStack(alignment: .trailing) {
                Text("1").border(Color.black).background(Color.yellow)
                        Text("2").border(Color.black).background(Color.yellow)
                        Text("3").border(Color.black).background(Color.yellow)
             
                        HStack(alignment: .top) {
                            Text("A").frame(width: 150, height: 150, alignment: .center).border(Color.black)
                            Text("B").border(Color.black)
                            Text("C").border(Color.black)
                        }
                        .background(Color.red)
                    }
                    .font(.title)
                    .foregroundColor(.black)
                    .background(Color.blue)
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
            
            Button(action: {
                print("Pulsé mi botón")
                buttonLabel = "Thanks!"
                
            }, label: {
                Text(buttonLabel)
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        ContentView()
    }
}

/*
 Vistas y controles en SwiftUI
 ¿Qué son las vistas?

 Las vistas son los que nos van a permitir presentar contenido en la pantalla.

 ¿Qué son los controles?

 Los controles son los que permiten manejar las interacciones con el usuario.

 ¿Es importante el orden de los modificadores de una vista?

 Si, dependiendo el orden en el que ponemos los modificadores nuestra vista tendrá un resultado.
 */
