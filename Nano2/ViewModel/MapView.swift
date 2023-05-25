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
        
//        uiView.showsUserLocation = true
        uiView.showsCompass = true
        
        if let userTrackingButton = uiView.subviews.first(where: { $0 is MKUserTrackingButton }) as? MKUserTrackingButton {
            userTrackingButton.frame = CGRect(origin: CGPoint(x: 16, y: 16), size: CGSize(width: 30, height: 30))
        } else {
            let userTrackingButton = MKUserTrackingButton(mapView: uiView)
            userTrackingButton.frame = CGRect(origin: CGPoint(x: 16, y: 16), size: CGSize(width: 30, height: 30))
            userTrackingButton.backgroundColor = UIColor.white
//            userTrackingButton.layer.borderColor = UIColor.white
//            userTrackingButton.layer.borderWidth = 2
            userTrackingButton.layer.cornerRadius = 10
            userTrackingButton.layer.opacity = 0.8
            uiView.addSubview(userTrackingButton)
        }
    }
    
    func updateAnnotations(from mapView: MKMapView) {
        mapView.removeAnnotations(mapView.annotations)
        var annotations: [CustomAnnotation] = []
        if !locationVM.landmarkPlace.isEmpty{
            for landmark in locationVM.landmarkPlace {
                //                annotations.append(LandmarkAnnotation(name: landmark.name!, lat: landmark.lat, long: landmark.long))
                let annotation = CustomAnnotation(name: landmark.name!, lat: landmark.lat, long: landmark.long)
                annotations.append(annotation)
            }
        }
        
        mapView.addAnnotations(annotations)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is CustomAnnotation else { return nil }
        
        let identifier = "CustomAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        
        // Set custom image for the annotation
        let imageView = UIImageView(image: UIImage(systemName: "photo.artframe"))
        imageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50) // Set the desired image size
        
        // Customize the image view (e.g., add border, corner radius, etc.)
        // ...
        
        // Set the custom image view as the left accessory view of the annotation view
        annotationView?.leftCalloutAccessoryView = imageView
        
        return annotationView
    }
}










