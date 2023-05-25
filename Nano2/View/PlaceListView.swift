//
//  PlaceListView.swift
//  Nano2
//
//  Created by beni garcia on 22/05/23.
//

import SwiftUI

struct PlaceListView: View {
    @EnvironmentObject var locationVM: LocationViewModel
    @Binding var tabs: Tabs
    var onTap: () -> ()
    
    var body: some View {
        VStack(alignment: .leading) {
            Rectangle()
                .frame(height: 8)
                .cornerRadius(22)
                .padding(.vertical)
                .gesture(TapGesture()
                    .onEnded(self.onTap)
                )
            HStack {
                Text("Quest Map")
                    .font(.largeTitle)
                    .foregroundColor(Color.primary_white)
                    .fontWeight(.bold)
                    .padding(.bottom,5)
                    .padding(.horizontal,3)
                Spacer()
            }
            .frame(width: UIScreen.main.bounds.size.width)
            .background(Color.primary_black)
            .gesture(TapGesture()
                .onEnded(self.onTap)
            )
            
            VStack(alignment: .leading, spacing: 10) {
                if !locationVM.landmarkPlace.isEmpty {
                    ForEach(Array(locationVM.landmarkPlace.enumerated()), id: \.element) { index, landmark in
                        
                        NavigationLink{
                            //                                                                tabs = .uploadImage
                            UploadQuest(tabs: $tabs, namePlace: landmark.name!, titlePlace: landmark.title!, currentLandmark: landmark)
                        }label: {
                            VStack(alignment: .leading){
                                Text("\(landmark.name!)")
                                    .font(.title2)
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                                Text("\(landmark.title!)")
                                    .font(.subheadline)
                                    .foregroundColor(Color(UIColor.lightGray))
                                Divider()
                            }
                            .padding()
                            .background(landmark.visited ? Color.primary_green : Color.primary_black)
                            .cornerRadius(12)
                        }
                        .onAppear(){
                            locationVM.fetchLandmark()
                        }
                    }
                }
                Spacer()
            }
            .padding(.horizontal,8)
            
        }
        .cornerRadius(10)
    }
    
}

struct PlaceListView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceListView(tabs: .constant(.mapQuest), onTap: {})
            .environmentObject(LocationViewModel())
    }
}
