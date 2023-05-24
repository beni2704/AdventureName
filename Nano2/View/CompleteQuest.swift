//
//  CompleteQuest.swift
//  Nano2
//
//  Created by beni garcia on 24/05/23.
//

import SwiftUI

struct CompleteQuest: View {
    var body: some View {
        ScrollView{
            VStack(spacing: 20){
                Text("Congratulations!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text("Congratulations on accomplishing your journey to the recommended places, your dedication and adventurous spirit have rewarded you with unforgettable experiences and cherished memories!")
                    .font(.title2)
                
                
                HStack{
                    VStack(alignment: .leading){
                        //rep
                        Text("1. Starbucks Coffee")
                            .font(.title2)
                        Image(systemName: "bolt.square.fill")
                            .resizable()
                            .frame(width: 250,height: 250)
                    }
                    Spacer()
                }
                .padding()
                .background(Color.secondary_black)
                .cornerRadius(14)
                
                Button{
                    
                }label: {
                    ButtonComponent(text: "Begin new Journey")
                }
            }
            .padding()
        }
    }
}

struct CompleteQuest_Previews: PreviewProvider {
    static var previews: some View {
        CompleteQuest()
    }
}
