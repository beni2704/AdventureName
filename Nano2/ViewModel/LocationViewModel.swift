//
//  LocationViewModel.swift
//  Nano2
//
//  Created by beni garcia on 23/05/23.
//

import CoreData
import Foundation
import SwiftUI
import MapKit

class LocationViewModel: ObservableObject{
    let manager = PersistenceController.shared
    
    func deleteLandmark() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "LandmarkEntity")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try manager.container.viewContext.execute(batchDeleteRequest)
        } catch {
            print("Error deleting Landmark entities: \(error.localizedDescription)")
        }
        
        save()
        
    }
    
    
    func addLandmark(name: String, title: String, long: Double, lat: Double){
        let newLandmark = LandmarkEntity(context: manager.container.viewContext)
        newLandmark.landmarkId = UUID()
        newLandmark.name = name
        newLandmark.title = title
        newLandmark.visited = false
        newLandmark.long = long
        newLandmark.lat = lat
        save()
    }
    
    func save(){
        do{
            try manager.container.viewContext.save()
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
    func addPhoto(landmark: LandmarkEntity, photo: Data){
        let newPhoto = landmark
        newPhoto.image = photo
        newPhoto.visited = true
        save()
    }
}
