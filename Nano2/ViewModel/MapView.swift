//
//  MapView.swift
//  Nano2
//
//  Created by beni garcia on 18/05/23.
//

import Foundation
import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @EnvironmentObject var locationVM: LocationViewModel
    
    func makeUIView(context: Context) -> MKMapView {
        let map = MKMapView()
        map.showsUserLocation = true
        map.delegate = context.coordinator
        return map
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        //
        updateAnnotations(from: uiView)
    }
    
    func updateAnnotations(from mapView: MKMapView) {
        mapView.removeAnnotations(mapView.annotations)
//        let annotations = self.landmarks.map(LandmarkAnnotation.init)
        var annotations: [LandmarkAnnotation] = []
//        ForEach(self.locationVM.landmarkPlace){ landmark in
//            annotations.append(LandmarkAnnotation(name: landmark.name!, lat: landmark.lat, long: landmark.long))
//        }
        if !locationVM.landmarkPlace.isEmpty{
            annotations.append(LandmarkAnnotation(name: locationVM.landmarkPlace[0].name!, lat: locationVM.landmarkPlace[0].lat, long: locationVM.landmarkPlace[0].long))
            annotations.append(LandmarkAnnotation(name: locationVM.landmarkPlace[1].name!, lat: locationVM.landmarkPlace[1].lat, long: locationVM.landmarkPlace[1].long))
            annotations.append(LandmarkAnnotation(name: locationVM.landmarkPlace[2].name!, lat: locationVM.landmarkPlace[2].lat, long: locationVM.landmarkPlace[2].long))
            annotations.append(LandmarkAnnotation(name: locationVM.landmarkPlace[3].name!, lat: locationVM.landmarkPlace[3].lat, long: locationVM.landmarkPlace[3].long))
        }
        
        mapView.addAnnotations(annotations)
    }
}
