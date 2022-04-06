//
//  PhotoListViewModel.swift
//  PlanetConcurrency
//
//  Created by Antonio Iacono on 31/03/22.
//

import Foundation

class PhotoListViewModel: ObservableObject{
    @Published var photos: [Photo] = []
    @Published var isLoading = false
    @Published var showAlert = false
    @Published var errorMessage: String?
    
    @MainActor
    func fetchPhoto() async {
        let apiService = APIService(urlString: "http://127.0.0.1:8080/planets")
        isLoading.toggle()
        defer {
            isLoading.toggle()
        }
        do {
            photos = try await apiService.getJSON()
        } catch {
            showAlert = true
            errorMessage = error.localizedDescription + "\nPlease contact the developer and provide this error and the steps to reproduce."
        }
    }
}


//extension PhotoListViewModel {
//    convenience init(forPreview: Bool = false) {
//        self.init()
//        if forPreview {
//            self.photos = Photo.mockPhoto
//        }
//    }
//}

