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
    
    
    func testResponse200() throws {
        
        
        let localObject = ComicModel(num: 2545, description: "P((B|A)|(A|B)) represents the probability that you'll mix up the order of the terms when using Bayesian notation." , publishedDate:  Date.convertToDate("2021", "11", "22") ?? Date(), link: "", image: nil, news: "", safeTitle: "Bayes' Theorem", title: "Bayes' Theorem", transcript: "")
        
        let localData = """
{"month": "11", "num": 2545, "link": "", "year": "2021", "news": "", "safe_title": "Bayes' Theorem", "transcript": "", "alt": "P((B|A)|(A|B)) represents the probability that you'll mix up the order of the terms when using Bayesian notation.", "img": "", "title": "Bayes' Theorem", "day": "22"}
"""
            .data(using: .ascii)
        
        
        
        var state200: NetworkChainProtocol = Response200()
        var state404: NetworkChainProtocol = NotResponse404()
        let state500: NetworkChainProtocol = ServerError500()
        
        
        state200.next = state404
        state404.next = state500
        
        let proccesdData: ComicModel = try! state200.calculate(localData!, status: 200)
          //  XCTAssertTrue(proccesdData != nil)
            XCTAssertEqual(localObject, proccesdData)
        
    }
    
    func testChainNotResponse404() throws {
        
        let dummyData = "dummy".data(using: .ascii)
        var state200: NetworkChainProtocol = Response200()
        var state404: NetworkChainProtocol = NotResponse404()
        let state500: NetworkChainProtocol = ServerError500()
        
        
        state200.next = state404
        state404.next = state500
        
        do {
        let _: ComicModel = try state200.calculate(dummyData!, status: 404)
            
        } catch let ex as NetworkErrors{
            XCTAssertEqual(ex.errorDescription, NetworkErrors.notFound.errorDescription)
        }
          //  XCTAssertTrue(proccesdData != nil)
        
    }
    
    func testServerError500() throws {
        
        let dummyData = "dummy".data(using: .ascii)
        var state200: NetworkChainProtocol = Response200()
        var state404: NetworkChainProtocol = NotResponse404()
        let state500: NetworkChainProtocol = ServerError500()
        
        
        state200.next = state404
        state404.next = state500
        
        do {
        let _: ComicModel = try state200.calculate(dummyData!, status: 500)
            
        } catch let ex as NetworkErrors{
            XCTAssertEqual(ex.errorDescription, NetworkErrors.internalServerError.errorDescription)
        }
          //  XCTAssertTrue(proccesdData != nil)
       
    }
    
    func testEndOfChainWithUndefindedStatusCode() throws {
        
        let dummyData = "dummy".data(using: .ascii)
        var state200: NetworkChainProtocol = Response200()
        var state404: NetworkChainProtocol = NotResponse404()
        let state500: NetworkChainProtocol = ServerError500()
        
        
        state200.next = state404
        state404.next = state500
        
        do {
        let _: ComicModel = try state200.calculate(dummyData!, status: 9545)
            
        } catch let ex as NetworkErrors{
            XCTAssertEqual(ex.errorDescription, NetworkErrors.endOfChain.errorDescription)
        }
          //  XCTAssertTrue(proccesdData != nil)
      
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
