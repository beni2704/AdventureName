//
//  ResultLocationView.swift
//  Nano2
//
//  Created by beni garcia on 22/05/23.
//

import SwiftUI
import MapKit

struct ResultLocationView: View {
    @FetchRequest(sortDescriptors: []) var landmarkList: FetchedResults<LandmarkEntity>
    @Binding var tabs: Tabs
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("Quest")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.vertical,1)
            
            Text("You've shared your interest with us, and now it's time to unlock extraordinary experiences tailored just for you. Begin your journey to visit these places and capture it for new experiences!")
                .font(.title3)
                .padding(.bottom,1)
            
            HStack{
                VStack(alignment: .leading){
                    if !landmarkList.isEmpty {
                        ForEach(Array(landmarkList.enumerated()), id: \.element) { (index, landmark) in
                            Text("\(index + 1). \(landmark.name!)")
                                .font(.title2)
                        }
                    }
                    else{
                        Text("Loading...")
                    }
                }
                Spacer()
            }
            .padding()
            .foregroundColor(Color.primary_white)
            .background(Color.secondary_black)
            .cornerRadius(8)
            .padding(.vertical)
            
            Button{
                tabs = .mapQuest
            }label: {
                ButtonComponent(text: "Confirm", isDisabled: false)
            }
            Spacer()
        }
        .padding(.horizontal,26)
    }
}

struct ResultLocationView_Previews: PreviewProvider {
    static var previews: some View {
        ResultLocationView(tabs: .constant(.showResultLocation))
    }
}
