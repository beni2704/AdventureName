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
    
    @Published var landmarkPlace: [LandmarkEntity] = []
//    @Published var landmarkPlace2: [LandmarkEntity2] = []
    
    func fetchLandmark(){
        let request = NSFetchRequest<LandmarkEntity>(entityName: "LandmarkEntity")
        
        withAnimation(Animation.default) {
            do{
                landmarkPlace = try manager.container.viewContext.fetch(request)
            }
            catch let error{
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteLandmark() {
        withAnimation {
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "LandmarkEntity")
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
            do {
                try manager.container.viewContext.execute(batchDeleteRequest)
                landmarkPlace.removeAll()
            } catch {
                print("Error deleting Landmark entities: \(error.localizedDescription)")
            }
            
            save()
        }
    }

    
    func addLandmark(name: String, title: String, long: Double, lat: Double){
        let newLandmark = LandmarkEntity(context: manager.container.viewContext)
        newLandmark.landmarkId = UUID()
        newLandmark.name = name
        newLandmark.title = title
        newLandmark.visited = false
        newLandmark.long = long
        newLandmark.lat = lat
        //save()
        landmarkPlace.append(newLandmark)
    }
    
//    func addLandmarks(_ items: [MKMapItem]){
//        landmarkPlace2 = items.map({ mapitem in
//            var newLandmark = LandmarkEntity2(
//                lat: mapitem.placemark.coordinate.latitude,
//                long: mapitem.placemark.coordinate.longitude,
//                visited: false)
//            newLandmark.landmarkId = UUID()
//            newLandmark.name = mapitem.name
//            newLandmark.title = mapitem.placemark.title
//            newLandmark.visited = false
//            return newLandmark
//        })
//    }
    
    
    func save(){
        withAnimation(Animation.default) {
            do{
                try manager.container.viewContext.save()
            }
            catch{
                print(error.localizedDescription)
            }
        }
    }
    
    func addPhoto(landmark: LandmarkEntity, photo: Data){
        let newPhoto = landmark
        newPhoto.image = photo
        newPhoto.visited = true
        save()
    }
}

//struct LandmarkEntity2: Identifiable{
//    var id: UUID {
//        return landmarkId!
//    }
//    var image: Data?
//    var landmarkId: UUID?
//    var lat: Double
//    var long: Double
//    var name: String?
//    var title: String?
//    var visited: Bool
//}
