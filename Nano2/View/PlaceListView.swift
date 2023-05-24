//
//  PlaceListView.swift
//  Nano2
//
//  Created by beni garcia on 22/05/23.
//

import SwiftUI

struct PlaceListView: View {
    @EnvironmentObject var locationVM: LocationViewModel
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
//                ForEach(self.landmarks, id: \.id) { landmark in
//                    VStack(alignment: .leading) {
//                        Text(landmark.name)
//                            .fontWeight(.bold)
//                        Text(landmark.title)
//                    }
//                }
                if !locationVM.landmarkPlace.isEmpty {
                    VStack(alignment: .leading){
                        Text("\(locationVM.landmarkPlace[0].name!)")
                            .font(.title2)
                        Text("\(locationVM.landmarkPlace[0].title!)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Divider()
                    }
                    VStack(alignment: .leading){
                        Text("\(locationVM.landmarkPlace[1].name!)")
                            .font(.title2)
                        Text("\(locationVM.landmarkPlace[1].title!)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Divider()
                    }
                    VStack(alignment: .leading){
                        Text("\(locationVM.landmarkPlace[2].name!)")
                            .font(.title2)
                        Text("\(locationVM.landmarkPlace[2].title!)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Divider()
                    }
                    VStack(alignment: .leading){
                        Text("\(locationVM.landmarkPlace[3].name!)")
                            .font(.title2)
                        Text("\(locationVM.landmarkPlace[3].title!)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Divider()
                    }
                }
                Spacer()
            }
            .padding(.horizontal)
            
        }
        .cornerRadius(10)
    }
}

struct PlaceListView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceListView(onTap: {})
            .environmentObject(LocationViewModel())
    }
}
