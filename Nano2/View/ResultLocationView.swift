//
//  ResultLocationView.swift
//  Nano2
//
//  Created by beni garcia on 22/05/23.
//

import SwiftUI
import MapKit

struct ResultLocationView: View {
    
    @EnvironmentObject var locationVM: LocationViewModel
    @EnvironmentObject var locationManager: LocationManager
    
    @Binding var tabs: Tabs
    @Binding var keyword: String
    
    func getNearByLandmarks() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = keyword
        let center = locationManager.location
        request.region = MKCoordinateRegion(center: center!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))

        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            if let response = response {
                let mapItems = response.mapItems
                let sortedMapItems = mapItems.sorted {
                    let location1 = w$0.placemark.location
                    let location2 = $1.placemark.location
                    let distance1 = center?.distance(from: location1!)
                    let distance2 = center?.distance(from: location2!)
                    return distance1 ?? 0 < distance2 ?? 0
                }
                
                let nearestMapItems = Array(sortedMapItems.prefix(4))
                
//                locationVM.addLandmarks(nearestMapItems)
                for nearestMapItem in nearestMapItems {
                    locationVM.addLandmark(name: nearestMapItem.placemark.name!, title: nearestMapItem.placemark.title!, long: nearestMapItem.placemark.coordinate.longitude, lat: nearestMapItem.placemark.coordinate.latitude)
                }
            }
        }
    }
    
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
//                    Text("\(locationVM.landmarkPlace.count)")
                    if !locationVM.landmarkPlace.isEmpty {
                        ForEach(Array(locationVM.landmarkPlace.enumerated()), id: \.element) { (index, landmark) in
                            Text("\(index + 1). \(landmark.name!)")
                                .font(.title2)
                        }
                    }
                    else{
                        Text("Loading")
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
        .onAppear{
            getNearByLandmarks()
        }
        .onReceive(locationVM.$landmarkPlace) { output in
            print(output)
        }
    }
}

struct ResultLocationView_Previews: PreviewProvider {
    static var previews: some View {
        ResultLocationView(tabs: .constant(.showResultLocation),keyword: .constant(""))
            .environmentObject(LocationViewModel())
    }
}
