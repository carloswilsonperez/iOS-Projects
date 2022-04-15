//
//  ZStack.swift
//  SwiftUI2
//
//  Created by Carlos Wilson on 28/08/21.
//

import SwiftUI

struct ZStack: View {
    var body: some View {
        VStack {
            Color.yellow
        }.ignoresSafeArea()
    }
}

struct ZStack_Previews: PreviewProvider {
    static var previews: some View {
        ZStack()
    }
}
