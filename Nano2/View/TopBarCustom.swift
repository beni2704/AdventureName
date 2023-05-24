//
//  TopBarCustom.swift
//  Nano2
//
//  Created by beni garcia on 24/05/23.
//

import SwiftUI

struct TopBarCustom: View {
    @Binding var tabs: Tabs
    var title: String
    var body: some View {
        HStack{
            Button{
                tabs = .mapQuest
            }label: {
                Image(systemName: "chevron.backward")
                    .resizable()
                    .frame(width: 15,height: 25)
                    .padding()
                    .foregroundColor(Color.primary_white)
            }
            Spacer()
            Text(title)
                .font(.title)
            Spacer()
            Button{
                tabs = .home
            }label: {
                Image(systemName: "chevron.backward")
                    .resizable()
                    .frame(width: 15,height: 25)
                    .padding()
                    .foregroundColor(Color.primary_white)
            }
            .hidden()
        }
        .background(Color.primary_black)
    }
}

struct TopBarCustom_Previews: PreviewProvider {
    static var previews: some View {
        TopBarCustom(tabs: .constant(.home), title: "Complete Journey")
    }
}
