//
//  RootView.swift
//  Nano2
//
//  Created by beni garcia on 17/05/23.
//

import SwiftUI

struct RootView: View {
    @State var tabs : Tabs = .home
    @State var inputName : String = ""
    
    var body: some View {
        VStack{
            Image(systemName: "location.square.fill")
                .resizable()
                .frame(width: 100,height: 100)
            TextField("Input your name", text: $inputName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .padding(.horizontal,50)
            
            Button{
                
            }label: {
                Text("Begin Journey")
            }
            
            
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
