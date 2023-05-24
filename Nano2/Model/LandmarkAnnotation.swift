//
//  LandmarkAnnotation.swift
//  Nano2
//
//  Created by beni garcia on 22/05/23.
//

import MapKit

class LandmarkAnnotation: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D

    init(name: String, lat: Double, long: Double) {
        self.title = name
        self.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
}
