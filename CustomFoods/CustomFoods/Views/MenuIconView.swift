//
//  MenuIconView.swift
//  CustomFoods
//
//  Created by Carlos Wilson on 22/12/21.
//

import SwiftUI

struct MenuIconView: View {
    var icon: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 7, style: .continuous)
                .fill(Color.purple)
                .frame(width: 30, height: 30)
            Image(systemName: icon)
                .foregroundColor(.white)
        }
    }
}
