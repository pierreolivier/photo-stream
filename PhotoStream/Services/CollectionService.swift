//
//  CollectionService.swift
//  PhotoStream
//
//  Created by Pierre-Olivier on 07/10/2024.
//

import Foundation
import Alamofire
import UIKit

struct PhotoResponse: Codable {
    let author: String
}

class CollectionService {
    static let shared = CollectionService()
    
    // API base url
    let url = "https://dummyjson.com/quotes"
    
    // Data
    var photos: [Photo] = []
    
    // Data listener
    var collectionListener: (([Photo]) -> Void)!
    
    func generateCollection() {
        print("Generating collection...")
        if (photos.isEmpty) {
            self.photos.append(Photo(id: 1, date: Date(timeIntervalSince1970: 1601672410), author: "Leonardo", image: UIImage(named: "Photo1")))
            self.photos.append(Photo(id: 2, date: Date(timeIntervalSince1970: 1601712410), author: "Walt", image: UIImage(named: "Photo2")))
            self.photos.append(Photo(id: 3, date: Date(timeIntervalSince1970: 1667412871), author: "Vincent", image: UIImage(named: "Photo3")))
            self.photos.append(Photo(id: 4, date: Date(timeIntervalSince1970: 1667512871), author: "Victor", image: UIImage(named: "Photo4")))
        }
        
        collectionListener?(self.photos)
    }
    
    func listenToCollection(completionHandler: @escaping ([Photo]) -> Void) {
        print("Listenning to collection updates...")
        
        self.collectionListener = completionHandler
    }
    
    func generateAuthor(completionHandler: @escaping (PhotoResponse) -> Void) -> Void {
        print("Generating author...")
        AF.request(url + "/random", method: .get).responseDecodable(of: PhotoResponse.self) { response in
            switch response.result {
                case .success(let photoResponse):
                    print("Author is \(photoResponse.author)")
                    completionHandler(photoResponse)
                
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
        }
    }
    
    func savePhoto(image: UIImage, author: String) {
        print("Saving photo...")
        self.photos.append(Photo(id: self.photos.count + 1, date: Date(), author: author, image: image))
        
        print("New photo is \(self.photos.count)")
        
        // Update collection
        collectionListener?(self.photos)
    }
}
