//
//  ButtonComponent.swift
//  Nano2
//
//  Created by beni garcia on 24/05/23.
//

import SwiftUI

struct ButtonComponent: View {
    var text: String
    var body: some View {
        HStack{
            Spacer()
                Text(text)
                    .font(.title3)
            Spacer()
        }
        .frame(height: 40)
        .background(Color.primary_green)
        .cornerRadius(17)
        .foregroundColor(Color.white)
    }
}

struct ButtonComponent_Previews: PreviewProvider {
    static var previews: some View {
        ButtonComponent(text: "Confirm")
    }
}
