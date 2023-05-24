//
//  TempView.swift
//  Nano2
//
//  Created by beni garcia on 24/05/23.
//

import SwiftUI

struct TempView: View {
    @State var showImage = false
    @State var useCamera = false
    @State var newItemImage = UIImage()
    
    var body: some View {
        HStack{
            Image(uiImage: newItemImage)
                .resizable()
                .cornerRadius(50)
                .padding(.all, 4)
                .frame(width: 100, height: 100)
                .background(Color.black.opacity(0.2))
                .aspectRatio(contentMode: .fill)
                .clipShape(Circle())
                .padding(8)
            Button{
                showImage.toggle()
            } label: {
                Text("Pilih Gambar").onTapGesture {
                    showImage.toggle()
                }
            }
            .sheet(isPresented: $showImage) {
//                ImagePicker(sourceType: .photoLibrary,selectedImage: $newItemImage, pickedImage: <#Binding<Bool>#>)
            }
            Spacer()
            Button{
                useCamera.toggle()
            } label: {
                Text("Ambil Gambar").onTapGesture {
                    useCamera.toggle()
                }
            }.sheet(isPresented: $useCamera) {
//                ImagePicker(sourceType: .camera,selectedImage: $newItemImage)
            }
        }

    }
}

struct TempView_Previews: PreviewProvider {
    static var previews: some View {
        TempView()
    }
}
