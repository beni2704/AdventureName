//
//  HomeView.swift
//  Nano2
//
//  Created by beni garcia on 22/05/23.
//

import SwiftUI
import MapKit
import CoreLocation

struct HomeView: View {
    @State var inputName : String = ""
    @Binding var tabs: Tabs
    @Binding var keyword: String
    
    @EnvironmentObject var locationVM: LocationViewModel
    
    var body: some View {
        VStack{
            Image(systemName: "location.square.fill")
                .resizable()
                .frame(width: 150, height: 150)
                .foregroundColor(Color.app_color)
                .padding()
            
            TextField("Input your interest", text: $inputName)
                .padding()
                .frame(height: 44)
                .foregroundColor(Color.primary_black)
                .background(Color.primary_white)
                .cornerRadius(22)
                .padding(.vertical,20)
                .padding(.horizontal,55)
            
            Button{
                locationVM.deleteLandmark()
                keyword = inputName
                tabs = .showResultLocation
            }label: {
                Text("Begin Adventure")
                    .frame(width: 200, height: 40)
                    .background(Color.primary_green)
                    .cornerRadius(17)
                    .foregroundColor(Color.white)
            }
            
            Button{
                tabs = .mapQuest
                locationVM.fetchLandmark()
            }label: {
                Text("Continue Journey")
                    .frame(width: 200, height: 40)
                    .background(Color.primary_green)
                    .cornerRadius(17)
                    .foregroundColor(Color.white)
                    .padding()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(tabs: .constant(.home),keyword: .constant(""))
    }
}
