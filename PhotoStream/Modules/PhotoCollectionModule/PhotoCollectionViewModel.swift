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
        loadData()
    }
    
    private func loadData() {
        self.photos = [
            Photo(id: 0, date: Date(timeIntervalSince1970: 1601672410), photo: UIImage(named: "Photo1")),
            Photo(id: 1, date: Date(timeIntervalSince1970: 1601712410), photo: UIImage(named: "Photo2")),
            Photo(id: 2, date: Date(timeIntervalSince1970: 1667412871), photo: UIImage(named: "Photo3")),
            Photo(id: 3, date: Date(timeIntervalSince1970: 1667512871), photo: UIImage(named: "Photo4"))
        ].sorted(by: { first, second in
            first.date > second.date
        })
    }
}
