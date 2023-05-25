//
//  CompleteQuest.swift
//  Nano2
//
//  Created by beni garcia on 24/05/23.
//

import SwiftUI

struct CompleteQuest: View {
    @FetchRequest(sortDescriptors: []) var landmarkList: FetchedResults<LandmarkEntity>
    @EnvironmentObject var locationVM: LocationViewModel
    @Binding var tabs: Tabs
    
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
                        if !(landmarkList.isEmpty) {
                            ForEach(Array(landmarkList.enumerated()), id: \.element) { (index, landmark) in
                                Text("\(index + 1). \(landmark.name!)")
                                    .font(.title2)
                                if landmark.image == nil {
                                    Image(systemName: "camera.fill")
                                        .resizable()
                                        .padding(30)
                                        .background(.gray)
                                        .frame(width: 300, height: 250)
                                        .border(Color.primary_white,width: 2)
                                        .padding(.bottom)
                                        .foregroundColor(Color.primary_white)
                                }else {
                                    Image(uiImage: UIImage(data: (landmark.image)!)!)
                                        .resizable()
                                        .background(.gray)
                                        .frame(width: 300, height: 250)
                                        .border(Color.primary_white,width: 2)
                                        .padding(.bottom)
                                        .foregroundColor(Color.primary_white)
                                }
                            }
                        
                        }
                    }
                    Spacer()
                }
                .padding()
                .background(Color.secondary_black)
                .cornerRadius(14)
                
                Button{
                    locationVM.deleteLandmark()
                    tabs = .home
                }label: {
                    ButtonComponent(text: "Begin new Journey", isDisabled: false)
                }
            }
            .padding()
        }
    }
}

struct CompleteQuest_Previews: PreviewProvider {
    static var previews: some View {
        CompleteQuest(tabs: .constant(.questSuccess))
            .environmentObject(LocationViewModel())
    }
}
