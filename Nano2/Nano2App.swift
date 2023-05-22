//
//  Nano2App.swift
//  Nano2
//
//  Created by beni garcia on 17/05/23.
//

import SwiftUI

@main
struct Nano2App: App {
    let persistenceController = PersistenceController.shared
    @StateObject var locationManager = LocationManager()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(LocationManager())
        }
    }
}
