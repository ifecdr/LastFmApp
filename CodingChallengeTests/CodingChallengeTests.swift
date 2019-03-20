//
//  CodingChallengeTests.swift
//  CodingChallengeTests
//
//  Created by mac on 3/19/19.
//  Copyright © 2019 mac. All rights reserved.
//

import XCTest
@testable import CodingChallenge

class CodingChallengeTests: XCTestCase {
    
    //state any variables used for test
    var viewModel: ViewModel!

    override func setUp() {
        //initialize any objects that you may need for testing
        super.setUp()
        viewModel = ViewModel()
    }

    override func tearDown() {
        // de init or reset variables to initial state for each function
        viewModel = nil
        super.tearDown()
    }

    func testContentCount() {
        //AAA - Arrange, Activate, Assert
        
        //1. Arrange
        viewModel.artistLimit = 0
        viewModel.albumLimit = 0
        
        //2. Activate
        viewModel.resetLimits()
        viewModel.updateLimits()
        
        //3. Asserts
        XCTAssertEqual(viewModel.artistLimit, 10)
        XCTAssertEqual(viewModel.albumLimit, 10)
    }

    func testServiceCall() {
        
        //1. Arrange
        var myAlbums = [Album]()
        var artist = [Artist]()
        
        //expectations - to wait for async call
        let promise = expectation(description: "receiving content..")
        
        //2. Activate
//        ContentService.shared.getAlbums(search: "Snoop", limit: 10) { albums in
//
//            myAlbums = albums
//            promise.fulfill()
//        }
        
        ContentService.shared.getArtists(search: "Asha", limit: 10) { (artists) in
            artist = artists
            promise.fulfill()
        }
        
        //set expectation wait time - in seconds
        waitForExpectations(timeout: 3, handler: nil)
        
        //3. Assert
        //XCTAssertTrue(myAlbums.count > 0)
        //XCTAssertEqual(myAlbums.count, 10)
        
        XCTAssertEqual(artist.count, 10)
        
        
        self.measure {
            //viewModel.getContent(with: "Kanye")
            viewModel.updateLimits()
        }
    }

}
