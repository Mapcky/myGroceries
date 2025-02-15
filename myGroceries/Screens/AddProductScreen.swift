//
//  AddProductScreen.swift
//  myGroceries
//
//  Created by Mateo Andres Perano on 09/02/2025.
//

import SwiftUI
import PhotosUI

struct AddProductScreen: View {

    // MARK: - PROPERTIES
    
    let product: Product?
    
    @State private var name: String = ""
    @State private var description: String = ""
    @State private var price: Double?
    
    private var isFormValid: Bool {
        !name.isEmptyOrWhiteSpaces && !description.isEmptyOrWhiteSpaces && (price ?? 0) > 0
    }
    
    @Environment(ProductStore.self) private var productStore
    @AppStorage("userId") private var userId: Int?
    @Environment(\.dismiss) private var dismiss
    
    @State private var selectedPhotoItem: PhotosPickerItem?
    @State private var isCameraSelected: Bool = false
    @State private var uiImage: UIImage?
    
    @Environment(\.uploaderDownloader) private var uploaderDownloader
    private var actionTitle: String {
        product != nil ? "Update Product" : "Add Product"
    }
    
    // MARK: - FUNCTIONS
    
    init(product: Product? = nil) {
        self.product = product
    }
    
    
    private func saveOrUpdateProduct() async {
        
        do {
            guard let uiImage = uiImage, let imageData = uiImage.pngData() else {
                throw ProductError.missingImage
            }
            
            let uploadDataResponsa = try await uploaderDownloader.upload(data: imageData)
            
            guard let downloadURL = uploadDataResponsa.downloadURL, uploadDataResponsa.success else {
                throw ProductError.uploadFailed(uploadDataResponsa.message ?? "")
            }
            
            guard let userId = userId else {
                throw ProductError.missingUserId
            }
            
            guard let price = price else {
                throw ProductError.invalidPrice
            }
            
            let product = Product(id: self.product?.id,description: description, name: name, price: price, photoUrl: downloadURL, userId: userId)
            
            if self.product != nil {
                try await productStore.updateProduct(product)
            } else {
                try await productStore.saveProdut(product)
            }
            
            dismiss()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    
    // MARK: - BODY
    var body: some View {
        Form {
            TextField("Enter name", text: $name)
            TextEditor(text: $description)
                .frame(height: 100)
            TextField("Enter price", value: $price, format: .number)
            
            Button(action: {
                
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    isCameraSelected = true
                } else {
                    print("Camera is not supported on this device")
                }
                
            }, label: {
                Image(systemName: "camera.fill")
            }).font(.title)
            
            
            PhotosPicker(selection: $selectedPhotoItem, matching: .images, photoLibrary: .shared()) {
                Image(systemName: "photo.on.rectangle")
            }.font(.title)
            if let uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            
        }//: FORM
        .task {
            do {
                guard let product = product else { return }
                name = product.name
                description = product.description
                price = product.price
                
                if let photoUrl = product.photoUrl {
                    guard let data = try await uploaderDownloader.download(from: photoUrl) else { return }
                    
                    uiImage = UIImage(data: data)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
            .task(id: selectedPhotoItem, {
                if let selectedPhotoItem {
                do {
                    if let data = try await selectedPhotoItem.loadTransferable(type: Data.self) {
                        uiImage = UIImage(data: data)
                    }
                } catch {
                    print(error.localizedDescription)
                    
                }
            }
        })//: TASK
        
        .sheet(isPresented: $isCameraSelected, content: {
            ImagePicker(image: $uiImage, sourceType: .camera)
        })//; SHEET
        
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing, content: {
                Button(actionTitle) {
                    Task {
                        await saveOrUpdateProduct()
                    }
                }.disabled(!isFormValid)
            })
        })//: TOOLBAR
        //.navigationTitle(actionTitle)
    }//: BODY
}

#Preview {
    NavigationStack{
        AddProductScreen()
    }.environment(ProductStore(httpClient: .development))
        .environment(\.uploaderDownloader, UploaderDownloader(httpClient: .development))
}
