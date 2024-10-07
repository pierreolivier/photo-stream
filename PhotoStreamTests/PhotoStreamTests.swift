//
//  PhotoStreamTests.swift
//  PhotoStreamTests
//
//  Created by Pierre-Olivier on 01/10/2024.
//

import XCTest
@testable import PhotoStream

final class PhotoStreamTests: XCTestCase {
    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGenerateCollection() throws {
        var currentPhotos: [Photo] = []
        
        CollectionService.shared.listenToCollection { photos in
            print("listenToCollection photos count:\(photos.count)")
            currentPhotos = photos
        }
        CollectionService.shared.generateCollection()
        print("currentPhotos count: \(currentPhotos.count)")
        
        XCTAssertEqual(currentPhotos.count, 4, "wrong photos count")
    }
    
    func testGenerateAuthor() throws {
        let expectation = self.expectation(description: "Data fetch completes")
        var currentAuthor = ""
        
        CollectionService.shared.generateAuthor { response in
            print("listenToCollection author:\(response.author)")
            currentAuthor = response.author
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
        
        print("currentAuthor: \(currentAuthor)")
        XCTAssertTrue(currentAuthor.count > 0, "author not generated")
    }

}
