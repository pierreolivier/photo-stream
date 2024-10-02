//
//  PhotoCollectionViewModel.swift
//  PhotoStream
//
//  Created by Pierre-Olivier on 02/10/2024.
//

import Foundation

class PhotoCollectionViewModel {
    @Published var photos: [Photo] = []
    
    init() {
        loadData()
    }
    
    private func loadData() {
        self.photos = [
            Photo(id: 0, date: Date(timeIntervalSince1970: 1601672410)),
            Photo(id: 0, date: Date(timeIntervalSince1970: 1667512871))
        ]
    }
}
