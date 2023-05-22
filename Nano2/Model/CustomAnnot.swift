//
//  CustomAnnot.swift
//  Nano2
//
//  Created by beni garcia on 22/05/23.
//

import Foundation
import MapKit

class CustomAnnot: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        super.init()
    }
}
