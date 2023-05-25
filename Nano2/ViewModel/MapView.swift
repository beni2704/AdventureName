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
    
    @FetchRequest(sortDescriptors: []) var landmarkList: FetchedResults<LandmarkEntity>
    
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
        updateAnnotations(from: uiView)
        uiView.showsCompass = true
        
        if let userTrackingButton = uiView.subviews.first(where: { $0 is MKUserTrackingButton }) as? MKUserTrackingButton {
            userTrackingButton.frame = CGRect(origin: CGPoint(x: 16, y: 16), size: CGSize(width: 30, height: 30))
        } else {
            let userTrackingButton = MKUserTrackingButton(mapView: uiView)
            userTrackingButton.frame = CGRect(origin: CGPoint(x: 16, y: 16), size: CGSize(width: 30, height: 30))
            userTrackingButton.backgroundColor = UIColor.white
            userTrackingButton.layer.cornerRadius = 10
            userTrackingButton.layer.opacity = 0.8
            uiView.addSubview(userTrackingButton)
        }
    }
    
    func updateAnnotations(from mapView: MKMapView) {
        mapView.removeAnnotations(mapView.annotations)
        var annotations: [CustomAnnotation] = []
        var annotation: CustomAnnotation?
        if !landmarkList.isEmpty{
            for landmark in landmarkList {
                if landmark.image == nil {
                    annotation = CustomAnnotation(name: landmark.name!, lat: landmark.lat, long: landmark.long)
                }else{
                    annotation = CustomAnnotation(name: landmark.name!, image: landmark.image! , lat: landmark.lat, long: landmark.long)
                }
                annotations.append(annotation!)
            }
        }
        mapView.addAnnotations(annotations)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        
        var control: MapView
        
        init(_ control: MapView) {
            self.control = control
        }
        
        func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
            
            if let annotationView = views.first {
                if let annotation = annotationView.annotation {
                    if annotation is MKUserLocation {
                        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
                        mapView.setRegion(region, animated: true)
                    }
                }
            }
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard let customAnnotation = annotation as? CustomAnnotation else {
                return nil
            }
            
            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier, for: annotation) as? MKMarkerAnnotationView
            annotationView?.annotation = customAnnotation
            annotationView?.canShowCallout = true
            
            annotationView?.titleVisibility = .visible
            annotationView?.subtitleVisibility = .visible
            
            if customAnnotation.image != nil {
//                customAnnotation.setImage(image: customAnnotation.image!)
//                annotationView?.glyphImage = UIImage(data: customAnnotation.image!)
                annotationView?.glyphTintColor = .black
                annotationView?.markerTintColor = .green
            }
            
            
            return annotationView
        }
    }
    
}










