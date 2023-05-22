//
//  MapQuestView.swift
//  Nano2
//
//  Created by beni garcia on 18/05/23.
//

import SwiftUI

struct MapQuestView: View {
    @Binding var landmarks: [Landmark]
    @State var tapped: Bool = false
    
    func calculateOffset() -> CGFloat {
        
        if self.landmarks.count > 0 && !self.tapped {
            return UIScreen.main.bounds.size.height - UIScreen.main.bounds.size.height / 4
        }
        else if self.tapped {
            return 100
        } else {
            return UIScreen.main.bounds.size.height
        }
    }
    
    var body: some View {
        VStack{
            MapView(landmarks: landmarks)
            
            
            
            PlaceListView(landmarks: $landmarks){
                self.tapped.toggle()
            }
        }
    }
}

struct MapQuestView_Previews: PreviewProvider {
    static var previews: some View {
        MapQuestView(landmarks: .constant([]))
    }
}
