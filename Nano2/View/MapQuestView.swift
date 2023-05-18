//
//  MapQuestView.swift
//  Nano2
//
//  Created by beni garcia on 18/05/23.
//

import SwiftUI

struct MapQuestView: View {
    @ObservedObject var locationManager = LocationManager()
    
    var body: some View {
        VStack{
            MapView()
        }
    }
}

struct MapQuestView_Previews: PreviewProvider {
    static var previews: some View {
        MapQuestView()
    }
}
