//
//  HomeView.swift
//  Nano2
//
//  Created by beni garcia on 22/05/23.
//

import SwiftUI
import MapKit
import CoreLocation

struct HomeView: View {
    @FetchRequest(sortDescriptors: []) var landmarkList: FetchedResults<LandmarkEntity>
    @State var inputName : String = ""
    @Binding var tabs: Tabs
    
    @EnvironmentObject var locationVM: LocationViewModel
    @EnvironmentObject var locationManager: LocationManager
    
    func getNearByLandmarks() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = inputName
        let center = locationManager.location
        request.region = MKCoordinateRegion(center: center!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))

        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            if let response = response {
                let mapItems = response.mapItems
                let sortedMapItems = mapItems.sorted {
                    let location1 = $0.placemark.location
                    let location2 = $1.placemark.location
                    let distance1 = center?.distance(from: location1!)
                    let distance2 = center?.distance(from: location2!)
                    return distance1 ?? 0 < distance2 ?? 0
                }
                
                let nearestMapItems = Array(sortedMapItems.prefix(4))
                
                for nearestMapItem in nearestMapItems {
                    locationVM.addLandmark(name: nearestMapItem.placemark.name!, title: nearestMapItem.placemark.title!, long: nearestMapItem.placemark.coordinate.longitude, lat: nearestMapItem.placemark.coordinate.latitude)
                }
            }
        }
    }
    
    
    var body: some View {
        VStack{
            Image(systemName: "location.square.fill")
                .resizable()
                .frame(width: 150, height: 150)
                .foregroundColor(Color.app_color)
                .padding()
            
            TextField(text: $inputName){
                Text("Input your interest").foregroundColor(Color.gray)
            }
                .padding()
                .frame(height: 44)
                .foregroundColor(Color.primary_black)
                .background(Color.primary_white)
                .cornerRadius(22)
                .padding(.vertical,20)
                .padding(.horizontal,55)
            
            Button{
                locationVM.deleteLandmark()
                getNearByLandmarks()
                tabs = .showResultLocation
            }label: {
                Text("Begin Adventure")
                    .frame(width: 200, height: 40)
                    .background(Color.primary_green)
                    .cornerRadius(17)
                    .foregroundColor(Color.white)
            }
            
            Button{
                tabs = .mapQuest
            }label: {
                Text("Continue Journey")
                    .frame(width: 200, height: 40)
                    .background(landmarkList.isEmpty ? Color.gray : Color.primary_green)
                    .cornerRadius(17)
                    .foregroundColor(Color.white)
                    .padding()
            }
            .disabled(landmarkList.isEmpty)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(tabs: .constant(.home))
    }
}
