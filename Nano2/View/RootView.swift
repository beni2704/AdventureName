//
//  RootView.swift
//  Nano2
//
//  Created by beni garcia on 17/05/23.
//

import SwiftUI
import MapKit

struct RootView: View {
    @State var tabs : Tabs = .home
    @State private var landmarks: [Landmark] = [Landmark]()
    @State var inputName : String = ""
    
    private func getNearByLandmarks() {
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = inputName
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            if let response = response {
                let mapItems = response.mapItems
                self.landmarks = mapItems.map {
                    Landmark(placemark: $0.placemark)
                }
            }
        }
    }
    
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
                getNearByLandmarks()
            }label: {
                Text("Begin Adventure")
            }
            
            ForEach(self.landmarks, id: \.id){ landmark in
                Text(landmark.name)
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
