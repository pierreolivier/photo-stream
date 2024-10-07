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
        CollectionService.shared.listenToCollection() { photos in
            self.photos = photos.sorted(by: { first, second in
                first.date > second.date
            })
        }
        
        loadData()
    }
    
    private func loadData() {
        CollectionService.shared.generateCollection()
    }
}
