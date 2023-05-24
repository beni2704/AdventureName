//
//  UploadQuest.swift
//  Nano2
//
//  Created by beni garcia on 24/05/23.
//

import SwiftUI

struct UploadQuest: View {
    @EnvironmentObject var locationVM: LocationViewModel
    @Binding var tabs: Tabs
    @State var showImage = false
    @State var useCamera = false
    @State var showAction = false
    @State var newItemImage = UIImage()
    @State var pickedImage = false
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Button{
                    tabs = .mapQuest
                }label: {
                    Image(systemName: "chevron.backward")
                        .resizable()
                        .frame(width: 15,height: 25)
                        .padding(.top)
                        .padding(.horizontal)
                        .foregroundColor(Color.primary_white)
                }
                Spacer()
                Text("Complete Quest")
                    .font(.title)
                    .padding(.top)
                    .padding(.horizontal)
                Spacer()
                Button{
                    
                }label: {
                    Image(systemName: "chevron.backward")
                        .resizable()
                        .frame(width: 15,height: 25)
                        .padding(.top)
                        .padding(.horizontal)
                        .foregroundColor(Color.primary_white)
                }
                .hidden()
            }
            .background(Color.primary_black)
            
            Rectangle()
                .foregroundColor(.white)
                .frame(height: 3)
            
            VStack(alignment: .leading,spacing: 10){
                Text("Starbucks Coffee")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text("Multimedia Nusantara University, Tangerang, Banten, Indonesia")
                    .font(.title2)
                    .padding(.bottom)
                
                HStack{
                    Spacer()
                    Button{
                        showAction.toggle()
                    }label: {
                        if !pickedImage {
                            Image(systemName: "camera.fill")
                                .resizable()
                                .padding(pickedImage ? 0 : 30)
                                .background(.gray)
                                .frame(width: 300, height: 250)
                                .border(Color.primary_white,width: 2)
                                .padding(.bottom)
                                .foregroundColor(Color.primary_white)
                        }else{
                            Image(uiImage: newItemImage)
                                .resizable()
                                .padding(pickedImage ? 0 : 30)
                                .background(.gray)
                                .frame(width: 300, height: 250)
                                .border(Color.primary_white,width: 2)
                                .padding(.bottom)
                                .foregroundColor(Color.primary_white)
                        }
                    }
                    .actionSheet(isPresented: $showAction){
                        ActionSheet(title: Text("Select Image"), message: nil, buttons: [
                            .default(Text("Camera"), action: {
                                sourceType = .camera
                                showImage = true
                            }),
                            .default(Text("Photo Library"), action: {
                                sourceType = .photoLibrary
                                showImage = true
                            }),
                            .cancel()
                        ])
                    }
                    .sheet(isPresented: $showImage) {
                        ImagePicker(sourceType: sourceType, selectedImage: $newItemImage, pickedImage: $pickedImage)
                    }
                    Spacer()
                }
                
                
                Button{
                    
                }label: {
                    ButtonComponent(text: "Upload")
                }
            }
            .padding(.horizontal)
            
            
            
            Spacer()
        }
    }
}

struct UploadQuest_Previews: PreviewProvider {
    static var previews: some View {
        UploadQuest(tabs: .constant(.mapQuest))
            .environmentObject(LocationViewModel())
    }
}
