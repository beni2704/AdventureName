//
//  LocationViewModel.swift
//  Nano2
//
//  Created by beni garcia on 23/05/23.
//

import CoreData
import Foundation
import SwiftUI

class LocationViewModel: ObservableObject{
    let manager = PersistenceController.shared
    @Published var landmarkPlace: [LandmarkEntity] = []
    
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
        newLandmark.name = name
        newLandmark.title = title
        newLandmark.visited = false
        newLandmark.long = long
        newLandmark.lat = lat
        save()
        landmarkPlace.append(newLandmark)
    }
    
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
}
