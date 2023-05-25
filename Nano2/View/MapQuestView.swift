//
//  MapQuestView.swift
//  Nano2
//
//  Created by beni garcia on 18/05/23.
//

import SwiftUI

struct MapQuestView: View {
    @Binding var tabs: Tabs
    @EnvironmentObject var locationVM: LocationViewModel
    @State var tapped: Bool = false
    
    func calculateOffset() -> CGFloat {
        if self.locationVM.landmarkPlace.count > 0 && !self.tapped {
            return UIScreen.main.bounds.size.height - UIScreen.main.bounds.size.height / 4
        }
        else if self.tapped {
            return 100
        } else {
            return UIScreen.main.bounds.size.height
        }
    }
    
    var body: some View {
        NavigationView(){
            ZStack(alignment: .top){
//                HStack{
//                    Button{
//                        tabs = .home
//                    }label: {
//                        Image(systemName: "chevron.backward")
//                            .resizable()
//                            .frame(width: 15,height: 25)
//                            .padding()
//                            .foregroundColor(Color.primary_white)
//                    }
//                    Spacer()
//                    Text("Quest Journey")
//                        .font(.title)
//                    Spacer()
//                    Button{
//
//                    }label: {
//                        Image(systemName: "chevron.backward")
//                            .resizable()
//                            .frame(width: 15,height: 25)
//                            .padding()
//                            .foregroundColor(Color.primary_white)
//                    }
//                    .hidden()
//                }
//                .background(Color.primary_black)
//                .zIndex(1)
                
                
                MapView()
                
                PlaceListView(tabs: $tabs){
                    self.tapped.toggle()
                }
                .animation(.spring())
                .background(Color.primary_black)
                .offset(y: calculateOffset())
            }
        }
    }
}

struct MapQuestView_Previews: PreviewProvider {
    static var previews: some View {
        MapQuestView(tabs: .constant(.mapQuest))
            .environmentObject(LocationViewModel())
    }
}
