//
//  CustomAnnot.swift
//  Nano2
//
//  Created by beni garcia on 22/05/23.
//

import Foundation
import MapKit

class CustomAnnotation: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    
    let title: String?
        
    init(name: String, lat: Double, long: Double) {
        self.title = name
        self.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        
        super.init()
    }
}
