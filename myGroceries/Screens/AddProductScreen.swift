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
    // MARK: - FUNCTIONS
    
    private func saveProduct() async {
        
        do {
            guard let userId = userId else {
                throw ProductSaveError.missingUserId
            }
            
            guard let price = price else {
                throw ProductSaveError.invalidPrice
            }
            
            let product = Product(description: description, name: name, price: price, photoUrl: URL(string: "http://localhost:8080/api/uploads/chair.png"), userId: userId)
            
            try await productStore.saveProdut(product)
            
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
            
        }
        .onChange(of: selectedPhotoItem, {
            selectedPhotoItem?.loadTransferable(type: Data.self, completionHandler: { result in
                switch result {
                    
                case .success(let data):
                    if let data {
                        uiImage = UIImage(data: data)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
        })
        
        .sheet(isPresented: $isCameraSelected, content: {
            ImagePicker(image: $uiImage, sourceType: .camera)
        })
        
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing, content: {
                Button("Save") {
                    Task {
                        await saveProduct()
                    }
                }.disabled(!isFormValid)
            })
        })
    }
}

#Preview {
    NavigationStack{
        AddProductScreen()
    }.environment(ProductStore(httpClient: .development))
}
