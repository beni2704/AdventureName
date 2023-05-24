//
//  ResultLocationView.swift
//  Nano2
//
//  Created by beni garcia on 22/05/23.
//

import SwiftUI

struct ResultLocationView: View {
    @EnvironmentObject var locationVM: LocationViewModel
    @Binding var tabs: Tabs
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("Quest")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.vertical,1)
            
            
            Text("You've shared your interest for '' with us, and now it's time to unlock extraordinary experiences tailored just for you. Begin your journey to visit these places and capture it for new experiences!")
                .font(.title3)
                .padding(.bottom,1)
            
            HStack{
                VStack(alignment: .leading){
//                    if !locationVM.landmarkPlace.isEmpty {
//                        ForEach(locationVM.landmarkPlace) { landmark in
//                            Text("1. \(landmark.name!)")
//                                .font(.title2)
//                        }
//                    }
                    if !locationVM.landmarkPlace.isEmpty {
                        Text("1. \(locationVM.landmarkPlace[0].name!)")
                            .font(.title2)
                        Text("2. \(locationVM.landmarkPlace[1].name!)")
                            .font(.title2)
                        Text("3. \(locationVM.landmarkPlace[2].name!)")
                            .font(.title2)
                        Text("4. \(locationVM.landmarkPlace[3].name!)")
                            .font(.title2)
                    }
                    
                    
//                        if !locationVM.landmarkPlace.isEmpty {
//                            ForEach(locationVM.landmarkPlace) { landmark in
//                                Text("1. \(landmark.name!)")
//                                    .font(.title2)
//                            }
//                        }
//                        else{
//                            Text("Loading")
//                        }
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
                ButtonComponent(text: "Confirm")
            }
            Spacer()
        }
        .padding(.horizontal,26)
        
    }
}

struct ResultLocationView_Previews: PreviewProvider {
    static var previews: some View {
        ResultLocationView(tabs: .constant(.showResultLocation))
            .environmentObject(LocationViewModel())
    }
}
