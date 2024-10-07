//
//  PhotoCollectionViewModel.swift
//  PhotoStream
//
//  Created by Pierre-Olivier on 02/10/2024.
//

import Foundation
import UIKit

class PhotoCollectionViewModel {
    @Published var photos: [Photo] = []
    
    init() {
        // Listen to collection update received by the service
        CollectionService.shared.listenToCollection() { photos in
            self.photos = photos.sorted(by: { first, second in
                first.date > second.date
            })
        }
        
        // Init first data
        loadData()
    }
    
    private func loadData() {
        CollectionService.shared.generateCollection()
    }
}
