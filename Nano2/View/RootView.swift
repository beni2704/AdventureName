//
//  RootView.swift
//  Nano2
//
//  Created by beni garcia on 17/05/23.
//

import SwiftUI

struct RootView: View {
    @State var tabs: Tabs = .home
    
    @EnvironmentObject var locationVM: LocationViewModel
    @State var inputKeyword: String = ""
    
    var body: some View {
        if tabs == .home {
            HomeView(tabs: $tabs, keyword: $inputKeyword)
        }else if tabs == .showResultLocation{
            ResultLocationView(tabs: $tabs, keyword: $inputKeyword)
        }else if tabs == .mapQuest{
            MapQuestView(tabs: $tabs)
        }else if tabs == .uploadImage{
//            UploadQuest(tabs: $tabs, namePlace: (locationVM.landmarkPlace.first?.name)!, titlePlace: (locationVM.landmarkPlace.first?.title)!, currentLandmark: locationVM.landmarkPlace.first!)
        }else if tabs == .questSuccess{
            CompleteQuest(tabs: $tabs)
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(inputKeyword: "")
    }
}
