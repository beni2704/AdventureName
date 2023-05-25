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
    var image: Data?
    let title: String?
        
    init(name: String, image: Data, lat: Double, long: Double) {
        self.title = name
        self.image = image
        self.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        super.init()
    }
    
    init(name: String, lat: Double, long: Double) {
        self.title = name
        self.image = nil
        self.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        super.init()
    }
    
    func setImage(image: Data){
        self.image = image
    }
}
