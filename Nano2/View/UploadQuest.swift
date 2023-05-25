//
//  UploadQuest.swift
//  Nano2
//
//  Created by beni garcia on 24/05/23.
//

import SwiftUI
import Photos

struct UploadQuest: View {
    
    @FetchRequest(sortDescriptors: []) var landmarkList: FetchedResults<LandmarkEntity>
    @EnvironmentObject var locationVM: LocationViewModel
    
    @Environment(\.dismiss) var dismiss
    @Binding var tabs: Tabs
    @State var showImage = false
    @State var useCamera = false
    @State var showAction = false
    @State var selectedImage = UIImage()
    @State var pickedImage = false
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    var namePlace: String
    var titlePlace: String
    var currentLandmark: LandmarkEntity
    
    var body: some View {
        VStack(alignment: .leading){
            Rectangle()
                .foregroundColor(.white)
                .frame(height: 3)
            
            VStack(alignment: .leading,spacing: 10){
                Text(namePlace)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text(titlePlace)
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
                            Image(uiImage: selectedImage)
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
                        ImagePicker(sourceType: sourceType, selectedImage: $selectedImage, pickedImage: $pickedImage)
                    }
                    Spacer()
                }
                
                Button{
                    let fixedPhoto = fixOrientation(img: selectedImage)
                    if landmarkList.isEmpty{
                        print("empty")
                    }else {
                        locationVM.addPhoto(landmark: currentLandmark, photo: fixedPhoto.pngData()!)
                        print("saved!")
                    }
                    savePhotoToLibrary(fixedPhoto)
                    
                    var totalLandmark = landmarkList.count
                    
                    for landmark in landmarkList {
                        if landmark.image != nil {
                            totalLandmark -= 1
                        }
                    }
                    
                    if totalLandmark == 0 {
                        tabs = .questSuccess
                    }else {
                        dismiss()
                    }
                    
                }label: {
                    ButtonComponent(text: "Upload", isDisabled: selectedImage == UIImage())
                }
                .disabled(selectedImage == UIImage())
            }
            .padding(.horizontal)
            Spacer()
        }
//        .navigationTitle("Upload Image Quest")
        .navigationBarBackButtonHidden(true)
        .toolbar(){
            ToolbarItem(placement: .navigationBarLeading){
                Button{
                    dismiss()
                }label: {
                    Image(systemName: "chevron.backward")
                        .resizable()
                        .frame(width: 15,height: 25)
                        .padding(.vertical)
                        .foregroundColor(Color.primary_white)
                }
            }
            ToolbarItem(placement: .principal){
                Text("Complete Quest")
                    .font(.title)
                    .padding(.vertical)
            }
        }
    }
    private func fixOrientation(img: UIImage) -> UIImage {
        if (img.imageOrientation == .up) {
            return img
        }
        
        UIGraphicsBeginImageContextWithOptions(img.size, false, img.scale)
        let rect = CGRect(x: 0, y: 0, width: img.size.width, height: img.size.height)
        img.draw(in: rect)
        
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return normalizedImage
    }
    
    private func savePhotoToLibrary(_ image: UIImage) {
        PHPhotoLibrary.requestAuthorization { status in
            guard status == .authorized else {
                print("Access to photo library denied.")
                return
            }
            
            PHPhotoLibrary.shared().performChanges {
                PHAssetChangeRequest.creationRequestForAsset(from: image)
            } completionHandler: { success, error in
                if let error = error {
                    print("Error saving photo to library:", error.localizedDescription)
                } else {
                    print("Photo saved to library.")
                }
            }
        }
    }
}

struct UploadQuest_Previews: PreviewProvider {
    static var previews: some View {
        UploadQuest(tabs: .constant(.mapQuest), namePlace: "Starbucks Coffee", titlePlace: "Multimedia Nusantara University, Tangerang, Banten, Indonesia", currentLandmark: LandmarkEntity())
            .environmentObject(LocationViewModel())
    }
}
