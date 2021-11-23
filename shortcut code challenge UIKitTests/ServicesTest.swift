//
//  ServicesTest.swift
//  shortcut code challenge UIKitTests
//
//  Created by Mohsen on 11/23/21.
//

import XCTest
@testable import shortcut_code_challenge_UIKit

class ServicesTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testgenerateCurrentUrl() throws {
        let localUrl = URL(string: "http://xkcd.com/info.0.json")
        
        let generatedUrl = Services.urlGenerator()
        
        XCTAssertEqual(localUrl, generatedUrl)
    }
    
    func testGenerateSpecificComicUrl() throws {
        let localUrl = URL(string: "http://xkcd.com/100/info.0.json")
        
        let generatedUrl = Services.urlGenerator(with: 100)
        
        XCTAssertEqual(localUrl, generatedUrl)
    }
    
    func testSaveComicOnCoreData() throws {
        let localData = ComicModel(num: 11, description: "comicDescription" , publishedDate:  Date(), link: "Comic Link", image: nil, news: "Comic News", safeTitle: "safe title", title: "title", transcript: "Transcript")
        var dataStorage = DataStorage()
        dataStorage.saveComic(localData, image: nil)
        
        let recordedData = dataStorage.retriveComics().filter({$0.num == 11}).first
        
        XCTAssertEqual(localData, recordedData!)
        
    }
    
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
