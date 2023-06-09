//
//  RootView.swift
//  Nano2
//
//  Created by beni garcia on 17/05/23.
//

import SwiftUI

struct RootView: View {
    @State var tabs: Tabs = .home
    
    var body: some View {
        if tabs == .home {
            HomeView(tabs: $tabs)
        }else if tabs == .showResultLocation{
            ResultLocationView(tabs: $tabs)
        }else if tabs == .mapQuest{
            MapQuestView(tabs: $tabs)
        }else if tabs == .questSuccess{
            CompleteQuest(tabs: $tabs)
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
