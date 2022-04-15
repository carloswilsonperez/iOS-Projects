//
//  MenuRowView.swift
//  CustomFoods
//
//  Created by Carlos Wilson on 22/12/21.
//

import SwiftUI

struct MenuRowView: View {
    var label: String
    var icon: String
    @State private var offsetX = 0
    
    var body: some View {
        HStack {
            if icon != "" {
                MenuIconView(icon: icon)
            }
            Text(label)
                .fontWeight(.bold)
                .padding()
                .offset(x: icon != "" ? 0 : -15)
        }
    }
}

struct MenuRowView_Previews: PreviewProvider {
    static var previews: some View {
        MenuRowView(label: "label", icon: "waveform.path.ecg")
    }
}
